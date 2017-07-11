data "template_file" "userdata" {
  template = "${file("modules/lc-asg/userdata.sh")}"
  vars {
    cluster_name = "${var.cluster_name}"
  }
}

# ------------- #
# - On Demain - #
# ------------- #

resource "aws_launch_configuration" "on-demain-lc" {
  name_prefix          = "${var.project_name}-ecs-on-demain-lc-"
  image_id             = "${var.image_id}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  ebs_optimized        = false
  user_data            = "${data.template_file.userdata.rendered}"
  instance_type        = "${var.on_demain_instance_type}"
  security_groups      = ["${split(",", var.security_groups)}"]
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "/dev/xvdcz"
    volume_size           = 22
    volume_type           = "gp2"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "on-demain-asg" {
  name                      = "${var.project_name}-ecs-on-demain-asg"
  launch_configuration      = "${aws_launch_configuration.on-demain-lc.name}"
  desired_capacity          = "${var.on_demain_asg_desired}"
  min_size                  = "${var.on_demain_asg_min}"
  max_size                  = "${var.on_demain_asg_max}"
  health_check_type         = "EC2"
  health_check_grace_period = 300
  availability_zones        = ["${split(",", var.on_demain_availability_zones)}"]
  vpc_zone_identifier       = ["${split(",", var.on_demain_vpc_zone_identifier)}"]
  force_delete              = true
  tag {
    key                 = "Creator"
    value               = "${var.creator}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-ecs"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Project"
    value               = "${var.project_name}"
    propagate_at_launch = "true"
  }
}

resource "aws_autoscaling_policy" "on-demain-asp-scaling-up" {
  name                   = "${var.project_name}-ecs-on-demain-asp-scaling-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.on-demain-asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "on-demain-cwma-scaling-up" {
  alarm_name          = "${var.project_name}-ecs-on-demain-cwma-scaling-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.on_demain_cwma_scaling_up_threshold}"
  dimensions {
    ClusterName = "${var.cluster_name}"
  }
  alarm_description = "Cluster memory reservation above ${var.on_demain_cwma_scaling_up_threshold}%"
  alarm_actions     = ["${aws_autoscaling_policy.on-demain-asp-scaling-up.arn}"]
}

resource "aws_autoscaling_policy" "on-demain-asp-scaling-down" {
  name                   = "${var.project_name}-ecs-on-demain-asp-scaling-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.on-demain-asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "on-demain-cwma-scaling-down" {
  alarm_name          = "${var.project_name}-ecs-on-demain-cwma-scaling-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.on_demain_cwma_scaling_down_threshold}"
  dimensions {
    ClusterName = "${var.cluster_name}"
  }
  alarm_description = "Cluster memory reservation below ${var.on_demain_cwma_scaling_down_threshold}%"
  alarm_actions     = ["${aws_autoscaling_policy.on-demain-asp-scaling-down.arn}"]
}

# -------- #
# - Spot - #
# -------- #

resource "aws_launch_configuration" "spot-lc" {
  name_prefix          = "${var.project_name}-ecs-spot-lc-"
  image_id             = "${var.image_id}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  ebs_optimized        = false
  spot_price           = "${var.spot_price}"
  user_data            = "${data.template_file.userdata.rendered}"
  instance_type        = "${var.spot_instance_type}"
  security_groups      = ["${split(",", var.security_groups)}"]
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "/dev/xvdcz"
    volume_size           = 22
    volume_type           = "gp2"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "spot-asg" {
  name                      = "${var.project_name}-ecs-spot-asg"
  launch_configuration      = "${aws_launch_configuration.spot-lc.name}"
  desired_capacity          = "${var.spot_asg_desired}"
  min_size                  = "${var.spot_asg_min}"
  max_size                  = "${var.spot_asg_max}"
  health_check_type         = "EC2"
  health_check_grace_period = 300
  availability_zones        = ["${split(",", var.spot_availability_zones)}"]
  vpc_zone_identifier       = ["${split(",", var.spot_vpc_zone_identifier)}"]
  force_delete              = true
  tag {
    key                 = "Creator"
    value               = "${var.creator}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-ecs"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Project"
    value               = "${var.project_name}"
    propagate_at_launch = "true"
  }
}

resource "aws_autoscaling_policy" "spot-asp-scaling-up" {
  name                   = "${var.project_name}-ecs-spot-asp-scaling-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.spot-asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "spot-cwma-scaling-up" {
  alarm_name          = "${var.project_name}-ecs-spot-cwma-scaling-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.spot_cwma_scaling_up_threshold}"
  dimensions {
      ClusterName = "${var.cluster_name}"
  }
  alarm_description = "Cluster memory reservation above ${var.spot_cwma_scaling_up_threshold}%"
  alarm_actions     = ["${aws_autoscaling_policy.spot-asp-scaling-up.arn}"]
}

resource "aws_autoscaling_policy" "spot-asp-scaling-down" {
  name                   = "${var.project_name}-ecs-spot-asp-scaling-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.spot-asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "spot-cwma-scaling-down" {
  alarm_name          = "${var.project_name}-ecs-spot-cwma-scaling-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.spot_cwma_scaling_down_threshold}"
  dimensions {
    ClusterName = "${var.cluster_name}"
  }
  alarm_description = "Cluster memory reservation below ${var.spot_cwma_scaling_down_threshold}%"
  alarm_actions     = ["${aws_autoscaling_policy.spot-asp-scaling-down.arn}"]
}

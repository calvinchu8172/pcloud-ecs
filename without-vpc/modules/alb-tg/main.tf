resource "aws_alb_target_group" "main" {
  name     = "${var.name}"
  port     = "${var.instance_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    timeout             = 10
    unhealthy_threshold = 10
    matcher             = "200,301"
  }
}

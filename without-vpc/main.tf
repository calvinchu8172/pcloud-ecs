provider "aws" {
  region = "${var.region}"
}

# -------------------------------------------- #
# - EC2 IAM Profile & ECS Cluster & LC & ASG - #
# -------------------------------------------- #

resource "aws_ecs_cluster" "main" {
  name = "${var.project}-${var.env}"
}

module "lc-asg" {
  source                                = "modules/lc-asg"
  project_name                          = "${var.project}-${var.env}"
  creator                               = "${var.creator}"
  image_id                              = "${lookup(var.amis, var.region)}"
  iam_instance_profile                  = "${lookup(var.iam_instance_profile, var.env)}"
  key_name                              = "${lookup(var.key_name, var.env)}"
  cluster_name                          = "${aws_ecs_cluster.main.name}"
  security_groups                       = "${lookup(var.sg-web-server, var.env)}"
  on_demain_instance_type               = "${lookup(var.on_demain_instance_type, var.env)}"
  on_demain_asg_desired                 = "${lookup(var.on_demain_asg_desired, var.env)}"
  on_demain_asg_min                     = "${lookup(var.on_demain_asg_min, var.env)}"
  on_demain_asg_max                     = "${lookup(var.on_demain_asg_max, var.env)}"
  on_demain_availability_zones          = "${lookup(var.vpc_availability_zone, var.region)}"
  on_demain_vpc_zone_identifier         = "${lookup(var.private_subnets, var.env)}"
  on_demain_cwma_scaling_up_threshold   = "${lookup(var.on_demain_cwma_scaling_up_threshold, var.env)}"
  on_demain_cwma_scaling_down_threshold = "${lookup(var.on_demain_cwma_scaling_down_threshold, var.env)}"
  spot_instance_type                    = "${lookup(var.spot_instance_type, var.env)}"
  spot_asg_desired                      = "${lookup(var.spot_asg_desired, var.env)}"
  spot_asg_min                          = "${lookup(var.spot_asg_min, var.env)}"
  spot_asg_max                          = "${lookup(var.spot_asg_max, var.env)}"
  spot_availability_zones               = "${lookup(var.vpc_availability_zone, var.region)}"
  spot_vpc_zone_identifier              = "${lookup(var.private_subnets, var.env)}"
  spot_price                            = "${lookup(var.spot_price, var.env)}"
  spot_cwma_scaling_up_threshold        = "${lookup(var.spot_cwma_scaling_up_threshold, var.env)}"
  spot_cwma_scaling_down_threshold      = "${lookup(var.spot_cwma_scaling_down_threshold, var.env)}"
}

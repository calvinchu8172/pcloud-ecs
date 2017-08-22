provider "aws" {
  region = "${var.region}"
}

# -------------------------------------------- #
# - EC2 IAM Profile & ECS Cluster & LC & ASG - #
# -------------------------------------------- #

resource "aws_ecs_cluster" "main" {
  name = "${var.project}-${var.env}"
}

data "aws_caller_identity" "current" {}

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


module "ecs-service-alexa-bot" {
  source                = "modules/ecs-service-alexa-bot"
  env                   = "${var.env}"
  region                = "${var.region}"
  current_account_id    = "${data.aws_caller_identity.current.account_id}"
  cluster_name          = "${aws_ecs_cluster.main.name}"
  cluster_id            = "${aws_ecs_cluster.main.id}"
  service_name          = "${var.project}-alexa-go-bot"
  family                = "${var.project}-${var.env}-alexa-go-bot"
  log_group_name        = "/aws/ecs/${var.project}-${var.env}-alexa-go-bot"
  alexa_bot_revision    = "${lookup(var.alexa_bot_revision, var.env)}"
  alexa_bot_memory      = "${lookup(var.alexa_bot_memory, var.env)}"
  alexa_bot_cpu         = "${lookup(var.alexa_bot_cpu, var.env)}"
  service_desired_count = "${lookup(var.alexa_bot_service_desired_count, var.env)}"
  host_port             = 5280
  container_port        = 5280

  serverless_project      = "${var.serverless_project}"
  debug                   = "${lookup(var.debug, var.env)}"
  pcloud_api_domain       = "${lookup(var.pcloud_api_domain, var.env)}"
  pcloud_xmpp_host        = "${lookup(var.pcloud_xmpp_host, var.env)}"    
  pcloud_register_v1_path = "${var.pcloud_register_v1_path}"    
  pcloud_magic_number     = "${var.pcloud_magic_number}"
  pcloud_web_redis_host   = "${lookup(var.pcloud_web_redis_host, var.env)}"
}
    
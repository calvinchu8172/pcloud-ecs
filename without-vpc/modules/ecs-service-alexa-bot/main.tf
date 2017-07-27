resource "aws_cloudwatch_log_group" "alexa-bot" {
  name          = "${var.log_group_name}"
  tags {
    Environment = "${var.env}"
    Application = "${var.service_name}"
  }
}

data "template_file" "task-definition" {
  template = "${file("${path.module}/task-definition.json")}"
  vars {
    env                     = "${var.env}"
    region                  = "${var.region}"
    family                  = "${var.family}"
    cluster_name            = "${var.cluster_name}"
    service_name            = "${var.service_name}"
    host_port               = "${var.host_port}"
    container_port          = "${var.container_port}"
    alexa_bot_revision      = "${var.alexa_bot_revision}"
    alexa_bot_memory        = "${var.alexa_bot_memory}"
    alexa_bot_cpu           = "${var.alexa_bot_cpu}"
    current_account_id      = "${var.current_account_id}"
    log_group_name          = "${var.log_group_name}"
    
    # For environment
    serverless_project      = "${var.serverless_project}"
    debug                   = "${var.debug}"
    pcloud_api_domain       = "${var.pcloud_api_domain}"
    pcloud_xmpp_host        = "${var.pcloud_xmpp_host}"    
    pcloud_register_v1_path = "${var.pcloud_register_v1_path}"    
    pcloud_magic_number     = "${var.pcloud_magic_number}"
    pcloud_web_redis_host   = "${var.pcloud_web_redis_host}"
  }
}

# Simply specify the family to find the latest ACTIVE revision in that family.
data "aws_ecs_task_definition" "alexa-bot" {
  task_definition = "${aws_ecs_task_definition.alexa-bot.family}"
}


resource "aws_ecs_task_definition" "alexa-bot" {
  family                = "${var.family}"
  container_definitions = "${data.template_file.task-definition.rendered}"
}

resource "aws_ecs_service" "alexa-bot" {
  name            = "${var.service_name}"
  cluster         = "${var.cluster_id}"
  desired_count   = "${var.service_desired_count}"
  task_definition = "${aws_ecs_task_definition.alexa-bot.family}:${max("${aws_ecs_task_definition.alexa-bot.revision}", "${data.aws_ecs_task_definition.alexa-bot.revision}")}"
}


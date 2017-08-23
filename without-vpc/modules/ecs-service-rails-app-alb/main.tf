data "template_file" "task-definition" {
  template = "${file("${path.module}/task-definition.json")}"
  vars {
    project               = "${var.project}"
    env                   = "${var.env}"
    cluster_name          = "${var.cluster_name}"
    service_name          = "${var.service_name}"
    host_port             = "${var.host_port}"
    container_port        = "${var.container_port}"
    rails_app_revision    = "${var.rails_app_revision}"
    rails_app_memory      = "${var.rails_app_memory}"
    rails_app_cpu         = "${var.rails_app_cpu}"
    rails_config_revision = "${var.rails_config_revision}"
    rails_config_memory   = "${var.rails_config_memory}"
    rails_config_cpu      = "${var.rails_config_cpu}"
    rails_log_memory      = "${var.rails_log_memory}"
    rails_log_cpu         = "${var.rails_log_cpu}"
  }
}

resource "aws_ecs_task_definition" "rails-app" {
  family                = "${var.family}"
  container_definitions = "${data.template_file.task-definition.rendered}"
}

resource "aws_ecs_service" "rails-app" {
  name            = "${var.service_name}"
  cluster         = "${var.cluster_name}"
  task_definition = "${aws_ecs_task_definition.rails-app.arn}"
  desired_count   = "${var.service_desired_count}"
  iam_role        = "${var.service_iam_role}"
  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name   = "rails-app"
    container_port   = "${var.container_port}"
  }
}

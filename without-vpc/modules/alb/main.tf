resource "aws_alb" "main" {
  name            = "${var.name}"
  internal        = false
  subnets         = ["${split(",", var.subnets)}"]
  security_groups = ["${split(",", var.security_groups)}"]

  enable_deletion_protection = false

  access_logs {
    bucket = "${var.access_logs_bucket}"
    prefix = "${var.access_logs_prefix}"
  }

  tags {
    Creator = "${var.creator}"
    Project = "${var.project_name}"
  }
}

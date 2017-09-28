# ---------- #
# - Common - #
# ---------- #

variable "region" {}

variable "env" {}

variable "creator" {}

variable "project" {
  default = "pcloud"
}

# --------------- #
# - Module: VPC - #
# --------------- #

variable "vpc_id" {
  default = {
    alpha = "vpc-d2450fb7"
    beta  = "vpc-ed6dd288"
    prod  = "vpc-196dd27c"
  }
}

variable "vpc_cidr_block" {
  default = {
    alpha = "10.112"
    beta  = "10.110"
    prod  = "10.109"
  }
}

variable "vpc_availability_zone" {
  default = {
    us-east-1 = "us-east-1c,us-east-1b,us-east-1d"
    us-west-1 = "us-west-1b,us-west-1c,us-west-1b"
  }
}

variable "private_subnets" {
  default = {
    alpha = "subnet-5bd47870,subnet-942147e3,subnet-480d8911"
    beta  = "subnet-a7756b8f,subnet-0b4d957c,subnet-49e21810"
    prod  = "subnet-29756b01,subnet-7804da0f,subnet-a9926af0"
  }
}

variable "public_subnets" {
  default = {
    alpha = "subnet-1a26406d,subnet-5cdd7177,subnet-ab0682f2"
    beta  = "subnet-4a51893d,subnet-f5fae0dd,subnet-fff60ca6"
    prod  = "subnet-08243c20,subnet-8d07d9fa,subnet-8e926ad7"
  }
}

variable "subspace" {
  type = "map"

  default = {
    name       = "myzyxel-subspace"
    owner_id   = "567710019248"
    vpc_id     = "vpc-fca64685"
    cidr_block = "10.108.0.0/16"
  }
}

# ------------------ #
# - Module: lc-asg - #
# ------------------ #

# amzn-ami-2017.03.e-amazon-ecs-optimized
variable "amis" {
  default = {
    us-east-1 = "ami-d61027ad"
  }
}

variable "iam_instance_profile" {
  default = {
    alpha = "pcloud_alpha"
    beta  = "pcloud_beta"
    prod  = "pcloud_production"
  }
}

variable "key_name" {
  description = "Name of AWS key pair"
  default = {
    alpha = "pcloud-alpha-201706301731"
    beta  = "pcloud-beta-201707271147"
    prod  = "pcloud-prod-201708091430"
  }
}

variable "sg-web-server" {
  default = {
    alpha = "sg-16cf5d72"
    beta  = "sg-fb60569e"
    prod  = "sg-21487e44"
  }
}

variable "on_demain_instance_type" {
  default = {
    alpha = "t2.medium"
    beta  = "t2.medium"
    prod  = "t2.medium"
  }
}

variable "on_demain_asg_min" {
  description = "Min numbers of servers in ASG"
  default = {
    alpha = "1"
    beta  = "3"
    prod  = "4"
  }
}

variable "on_demain_asg_max" {
  description = "Max numbers of servers in ASG"
  default = {
    alpha = "1"
    beta  = "6"
    prod  = "6"
  }
}

variable "on_demain_asg_desired" {
  description = "Desired numbers of servers in ASG"
  default = {
    alpha = "1"
    beta  = "3"
    prod  = "4"
  }
}

variable "on_demain_cwma_scaling_up_threshold" {
  default = {
    alpha = "100"
    beta  = "75"
    prod  = "75"
  }
}

variable "on_demain_cwma_scaling_down_threshold" {
  default = {
    alpha = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_instance_type" {
  default = {
    alpha = "m4.large"
    beta  = "m4.large"
    prod  = "m4.large"
  }
}

variable "spot_asg_min" {
  description = "Min numbers of servers in ASG"
  default = {
    alpha = "3"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_asg_max" {
  description = "Max numbers of servers in ASG"
  default = {
    alpha = "6"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_asg_desired" {
  description = "Desired numbers of servers in ASG"
  default = {
    alpha = "3"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_price" {
  default = {
    alpha = "0.035"
    beta  = "0.01"
    prod  = "0.030"
  }
}

variable "spot_cwma_scaling_up_threshold" {
  default = {
    alpha = "75"
    beta  = "100"
    prod  = "100"
  }
}

variable "spot_cwma_scaling_down_threshold" {
  default = {
    alpha = "40"
    beta  = "0"
    prod  = "0"
  }
}

# ------- #
# - ALB - #
# ------- #

variable "access_logs_bucket" {
  default = {
    alpha = "pcloud-aws-logs"
    beta  = "personal-cloud-aws-logs"
    prod  = "personal-cloud-aws-logs"
  }
}

variable "access_logs_prefix" {
  default = {
    alpha = "elb/us-east-1/alpha"
    beta  = "elb/us-east-1/beta"
    prod  = "elb/us-east-1/prod"
  }
}

variable "elb_sg" {
  default = {
    alpha = "sg-33f36157"
    beta  = "sg-06b89063"
    prod  = "sg-aca78fc9"
  }
}

# --------------------------------- #
# - Module: ecs-service-alexa-bot - #
# --------------------------------- #

variable "alexa_bot_revision" {
  default = {
    alpha = "develop"
    beta  = "master"
    prod  = "master"
  }
}

variable "alexa_bot_memory" {
  default = {
    alpha = "1950"
    beta  = "1950"
    prod  = "1950"
  }
}

variable "alexa_bot_cpu" {
  default = {
    alpha = "1024"
    beta  = "1024"
    prod  = "512"
  }
}


variable "alexa_bot_service_desired_count" {
  default = {
    alpha = "2"
    beta  = "2"
    prod  = "4"
  }
}

# For environments

variable "serverless_project" {
  default = "personal-cloud-alexa"
}

variable "debug" {
  default = {
    alpha = "true"
    beta  = "true"
    prod  = "true"
  }
}

variable "pcloud_api_domain" {
  default = {
    alpha = "https://api-mycloud-alpha.zyxel.ecoworkinc.com"
    beta  = "https://api-mycloud-beta.zyxel.com"
    prod  = "https://api-mycloud.zyxel.com"
  }
}

variable "pcloud_xmpp_host" {
  default = {
    alpha = "alpha.xmpp.zyxel.com"
    beta  = "beta.xmpp.zyxel.com"
    prod  = "xmpp.zyxel.com"
  }
}

variable "pcloud_register_v1_path" {
  default = "/d/1/register"
}

variable "pcloud_magic_number" {
  default = "5889"
}

variable "pcloud_web_redis_host" {
  default = {
    alpha = "pcloud-alpha-web-rg.yypz2x.ng.0001.use1.cache.amazonaws.com"
    beta  = "pcloud-beta-web-rg.hcv1lh.ng.0001.use1.cache.amazonaws.com"
    prod  = "pcloud-prod-web-rg.hcv1lh.ng.0001.use1.cache.amazonaws.com"
  }
}

# --------------------------------- #
# - Module: ecs-service-rails-app - #
# --------------------------------- #

variable "rails_app_memory" {
  default = {
    alpha = "1500"
    beta  = "1600"
    prod  = "1600"
  }
}

variable "rails_app_cpu" {
  default = {
    alpha = "450"
    beta  = "900"
    prod  = "900"
  }
}

variable "rails_config_memory" {
  default = {
    alpha = "70"
    beta  = "70"
    prod  = "70"
  }
}

variable "rails_config_cpu" {
  default = {
    alpha = "12"
    beta  = "24"
    prod  = "24"
  }
}

variable "rails_log_memory" {
  default = {
    alpha = "300"
    beta  = "300"
    prod  = "300"
  }
}

variable "rails_log_cpu" {
  default = {
    alpha = "50"
    beta  = "100"
    prod  = "100"
  }
}

# ---------- #
# - Config - #
# ---------- #

variable "config_revision" {
  default = {
    alpha = "develop"
    beta  = "1.0.0"
    prod  = "1.0.0"
  }
}

# ----------- #
# - Console - #
# ----------- #

variable "console_revision" {
  default = {
    alpha = "develop"
    beta  = "2.13.0"
    prod  = "2.13.0"
  }
}

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

# amzn-ami-2017.03.d-amazon-ecs-optimized
variable "amis" {
  default = {
    us-east-1 = "ami-04351e12"
  }
}

variable "iam_instance_profile" {
  default = {
    alpha = "pcloud_alpha"
    beta  = "pcloud_beta"
    prod  = ""
  }
}

variable "key_name" {
  description = "Name of AWS key pair"
  default = {
    alpha = "pcloud-alpha-201706301731"
    beta  = "pcloud-beta-201707271147"
    prod  = ""
  }
}

variable "sg-web-server" {
  default = {
    alpha = "sg-16cf5d72"
    beta  = "sg-fb60569e"
    prod  = ""
  }
}

variable "private_subnets" {
  default = {
    alpha = "subnet-5bd47870,subnet-942147e3,subnet-480d8911"
    beta  = "subnet-a7756b8f,subnet-0b4d957c,subnet-49e21810"
    prod  = ""
  }
}

variable "on_demain_instance_type" {
  default = {
    alpha = "t2.medium"
    beta  = "t2.medium"
    prod  = "m3.large"
  }
}

variable "on_demain_asg_min" {
  description = "Min numbers of servers in ASG"
  default = {
    alpha = "0"
    beta  = "1"
    prod  = "0"
  }
}

variable "on_demain_asg_max" {
  description = "Max numbers of servers in ASG"
  default = {
    alpha = "0"
    beta  = "1"
    prod  = "0"
  }
}

variable "on_demain_asg_desired" {
  description = "Desired numbers of servers in ASG"
  default = {
    alpha = "0"
    beta  = "1"
    prod  = "0"
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
    beta  = "t2.medium"
    prod  = "m4.large"
  }
}

variable "spot_asg_min" {
  description = "Min numbers of servers in ASG"
  default = {
    alpha = "2"
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
    alpha = "2"
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



# --------------------------------- #
# - Module: ecs-service-alexa-bot - #
# --------------------------------- #

variable "alexa_bot_revision" {
  default = {
    alpha = "develop"
    beta  = "master"
    prod  = "latest"
  }
}

variable "alexa_bot_memory" {
  default = {
    alpha = "1996"
    beta  = "1996"
    prod  = "1500"
  }
}

variable "alexa_bot_cpu" {
  default = {
    alpha = "512"
    beta  = "512"
    prod  = "450"
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
    prod  = "false"
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
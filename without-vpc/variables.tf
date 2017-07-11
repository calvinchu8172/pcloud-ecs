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
    sit   = "10.111"
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
    sit   = ""
    beta  = ""
    prod  = ""
  }
}

variable "key_name" {
  description = "Name of AWS key pair"
  default = {
    alpha = "pcloud-alpha-201706301731"
    sit   = ""
    beta  = ""
    prod  = ""
  }
}

variable "sg-web-server" {
  default = {
    alpha = "sg-16cf5d72"
    sit   = ""
    beta  = ""
    prod  = ""
  }
}

variable "private_subnets" {
  default = {
    alpha = "subnet-5bd47870,subnet-942147e3,subnet-480d8911"
    sit   = ""
    beta  = ""
    prod  = ""
  }
}

variable "on_demain_instance_type" {
  default = {
    alpha = "t2.medium"
    sit   = "t2.medium"
    beta  = "t2.medium"
    prod  = "m3.large"
  }
}

variable "on_demain_asg_min" {
  description = "Min numbers of servers in ASG"
  default = {
    alpha = "0"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "on_demain_asg_max" {
  description = "Max numbers of servers in ASG"
  default = {
    alpha = "0"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "on_demain_asg_desired" {
  description = "Desired numbers of servers in ASG"
  default = {
    alpha = "0"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "on_demain_cwma_scaling_up_threshold" {
  default = {
    alpha = "100"
    sit   = "75"
    beta  = "75"
    prod  = "75"
  }
}

variable "on_demain_cwma_scaling_down_threshold" {
  default = {
    alpha = "0"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_instance_type" {
  default = {
    alpha = "m4.large"
    sit   = "t2.medium"
    beta  = "t2.medium"
    prod  = "m4.large"
  }
}

variable "spot_asg_min" {
  description = "Min numbers of servers in ASG"
  default = {
    alpha = "1"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_asg_max" {
  description = "Max numbers of servers in ASG"
  default = {
    alpha = "1"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_asg_desired" {
  description = "Desired numbers of servers in ASG"
  default = {
    alpha = "1"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

variable "spot_price" {
  default = {
    alpha = "0.035"
    sit   = "0.01"
    beta  = "0.01"
    prod  = "0.030"
  }
}

variable "spot_cwma_scaling_up_threshold" {
  default = {
    alpha = "75"
    sit   = "100"
    beta  = "100"
    prod  = "100"
  }
}

variable "spot_cwma_scaling_down_threshold" {
  default = {
    alpha = "40"
    sit   = "0"
    beta  = "0"
    prod  = "0"
  }
}

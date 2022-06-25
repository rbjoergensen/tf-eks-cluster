# Cluster
variable "cluster_name" {
  type    = string
  default = "cluster-01"
}

variable "cluster_version" {
  type    = string
  default = "1.22"
}

# Nodegroups
variable "ec2_intance_types" {
  type    = list(string)
  default = [ "t3.medium" ] # 2 vCPU / 4 Mem ($0.0418h)
}

variable "nodegroup_desired" {
  type    = number
  default = 1
}

variable "nodegroup_max" {
  type    = number
  default = 1
}

variable "nodegroup_min" {
  type    = number
  default = 1
}

# Networking
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  default = [
    { cidr = "10.0.0.0/24", zone = "eu-central-1a" },
    { cidr = "10.0.1.0/24", zone = "eu-central-1b" },
    { cidr = "10.0.2.0/24", zone = "eu-central-1c" }
  ]
}

# Logging
variable "log_retention" {
  type    = number
  default = 7
}
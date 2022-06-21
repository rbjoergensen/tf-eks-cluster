variable "cluster_name" {
  type    = string
  default = "cluster-01"
}

variable "cluster_version" {
  type    = string
  default = "1.20"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

locals {
  subnets = [
    { cidr = "10.0.0.0/24", zone = "eu-central-1a" },
    { cidr = "10.0.1.0/24", zone = "eu-central-1b" },
    { cidr = "10.0.2.0/24", zone = "eu-central-1c" }]
}

variable "log_retention" {
  type    = number
  default = 7
}
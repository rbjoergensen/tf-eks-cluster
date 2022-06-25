# Terraform module - AWS Kubernetes cluster
Terraform module for creating a Kubernetes cluster in AWS with the following optional features.

- Create access role for the cluster and update the default aws-auth configmap
- Dynamically adjust subnet count

Features that are not yet implemented:

- Service account for deploying to cluster using AWS credentials
- Logging of non-system containers to CloudWatch
- Setup of Prometheus and Grafana as well as alerts and dashboards
- Load balancing and automatic certificates for services

## Parameters
|Parameter          |Required|Default      |Type        |Description|
|-------------------|--------|-------------|------------|-----------|
|`cluster_name`     |true    |             |string      |Name of the cluster which is also used for names of roles, nodegroups and such|
|`cluster_version`  |true    |1.22         |string      |The version of Kubernetes to run, can only upgrade, not downgrade|
|`ec2_intance_types`|true    |["t3.medium"]|list(string)|A list of the instance types to use in the cluster|
|`nodegroup_desired`|true    |1            |number      |Desired amount of nodes in the cluster|
|`nodegroup_max`    |true    |1            |number      |Maximum amount of nodes in the cluster|
|`nodegroup_min`    |true    |1            |number      |Minimum amount of nodes in the cluster|
|`vpc_cidr`         |true    |10.0.0.0/16  |string      |the cidr of the VPC|
|`subnets`          |true    |             |list(object)|[{ cidr = "10.0.0.0/24", zone = "eu-central-1a" },{ cidr = "10.0.1.0/24", zone = "eu-central-1b" },{ cidr = "10.0.2.0/24", zone = "eu-central-1c" }]|
|`log_retention`    |true    |7            |number      |Days before cluster logs are deleted from the CloudWatch log group|

## Outputs
The module outputs these variables.

|Name   |Example                            |Description                                         |
|-------|-----------------------------------|----------------------------------------------------|
|cluster|`module.my_module.cluster.endpoint`|Contains authentication information and cluster info|
|vpc    |`module.my_module.vpc.arn`         |All data for the VPC if additional setup is needed  |
|subnets|`module.my_module.subnets.0.arn`   |Contains info about all subnets                     |

## Example
``` terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=4.19.0"
    }
  }
}

provider "aws" {
  alias  = "frankfurt"
  region = "eu-central-1"
}

module "cluster" {
  providers = { 
    aws = aws.frankfurt,
  }
  source            = "git::https://github.com/rbjoergensen/tf-eks-cluster.git?ref=v1"
  cluster_name      = "cluster-01"
  cluster_version   = "1.22"
  ec2_intance_types = [ "t3.medium" ]
  nodegroup_desired = 1
  nodegroup_max     = 1
  nodegroup_min     = 1
  vpc_cidr          = "10.0.0.0/16"
  subnets           = [
    { cidr = "10.0.0.0/24", zone = "eu-central-1a" },
    { cidr = "10.0.1.0/24", zone = "eu-central-1b" },
    { cidr = "10.0.2.0/24", zone = "eu-central-1c" }
  ]
  log_retention     = 7


}
```
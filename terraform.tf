terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=4.19.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "=2.11.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.main.token
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}
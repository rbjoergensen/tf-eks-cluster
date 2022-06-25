output "cluster" {
  value     = aws_eks_cluster.main
  sensitive = true
}

output "vpc" {
  value = aws_vpc.main
}

output "subnets" {
  value = aws_subnet.subnets
}
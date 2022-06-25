resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "eks-nodegroup-${var.cluster_name}"
  node_role_arn   = aws_iam_role.nodegroup.arn
  subnet_ids      = values(aws_subnet.subnets)[*].id
  instance_types  = var.ec2_intance_types

  scaling_config {
    desired_size = var.nodegroup_desired
    max_size     = var.nodegroup_max
    min_size     = var.nodegroup_min
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.main
  ]
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
}
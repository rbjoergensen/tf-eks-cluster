resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_retention
}
resource "aws_iam_role" "cluster_admin" {
  name = "eks-${var.cluster_name}-admin-test"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::470214011505:user/rasmus"
          ]
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_policy" "eks_user_policy" {
  name        = "eks-${var.cluster_name}-user-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:AccessKubernetesApi",
          "eks:DescribeCluster"
        ]
        Effect   = "Allow"
        Resource = aws_eks_cluster.main.arn
      },
      {
        Action = [
          "eks:ListClusters",
          "eks:DescribeCluster"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_user_policy_attachment" {
  role       = aws_iam_role.cluster_admin.name
  policy_arn = aws_iam_policy.eks_user_policy.arn
}
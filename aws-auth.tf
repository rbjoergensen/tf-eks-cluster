resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = "${yamlencode(local.aws_auth_roles)}"
  }
}

locals {
  aws_auth = {
    apiVersion = "v1"
    kind = "ConfigMap"
    metadata = {
      name = "aws-auth"
      namespace = "kube-system"
    }
    data = {
      mapRoles = "${yamlencode(local.aws_auth_roles)}"
    }
  }
  aws_auth_roles = [
    {
      rolearn = aws_iam_role.nodegroup.arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes"
      ]
    },
    {
      rolearn = aws_iam_role.cluster_admin.arn
      username = aws_iam_role.cluster_admin.name
      groups = [
        "system:masters"
      ]
    }
  ]
}

#  mapUsers: |
#    - userarn: arn:aws:iam::00000000000:user/svc_github_deploy_eks
#      username: svc_github_deploy_eks
#      groups:
#        - system:masters
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode([
      {
        userarn  = data.aws_iam_user.read_only_access_user.arn
        username = data.aws_iam_user.read_only_access_user.user_name
        groups   = ["system:masters"]
      }
    ])
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = [
    aws_eks_cluster.main
  ]
}

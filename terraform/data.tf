data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster_auth" "main" {
  name = local.cluster_name

  depends_on = [
    aws_eks_cluster.main
  ]
}

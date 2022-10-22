resource "aws_eks_cluster" "main" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    security_group_ids = [aws_security_group.main.id]
    subnet_ids         = aws_subnet.main[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_cluster_service_policy
  ]
}

resource "aws_eks_node_group" "main" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.value.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.main[*].id
  instance_types  = [each.value.node_group_instance_type]
  ami_type        = each.value.node_group_ami_type
  

  scaling_config {
    desired_size = each.value.desired_worker_nodes
    max_size     = each.value.max_worker_nodes
    min_size     = each.value.min_worker_nodes
  }

  labels = {
    name = each.value.node_group_name
  }

  dynamic "taint" {
    for_each = each.value.taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    kubernetes_config_map.aws_auth
  ]
}

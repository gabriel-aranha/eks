resource "helm_release" "main" {
  for_each = var.helm_charts

  name             = each.value.name
  repository       = each.value.repository
  chart            = each.value.chart
  namespace        = each.value.namespace
  atomic           = true
  create_namespace = true

  dynamic "set" {
    for_each = each.value.overrides
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set" {
    for_each = each.value.custom_overrides
    content {
      name  = set.value.name
      value = local.custom_overrides[set.value.name]
    }
  }

  depends_on = [
    aws_eks_node_group.main
  ]
}

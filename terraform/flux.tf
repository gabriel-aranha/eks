data "flux_install" "main" {
  target_path = var.target_path
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }

  depends_on = [
    aws_eks_cluster.main
  ]
}

data "kubectl_file_documents" "flux_install" {
  content = data.flux_install.main.content
}

resource "kubectl_manifest" "flux_install" {
  for_each   = { for v in local.flux_install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  yaml_body = each.value

  depends_on = [
    kubernetes_namespace.flux_system
  ]
}

data "flux_sync" "main" {
  target_path = var.target_path
  url         = github_repository.main.http_clone_url
}

data "kubectl_file_documents" "flux_sync" {
  content = data.flux_sync.main.content
}

resource "kubectl_manifest" "flux_sync" {
  for_each   = { for v in local.flux_sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  yaml_body = each.value

  depends_on = [
    kubernetes_namespace.flux_system
  ]
}

resource "kubernetes_secret" "main" {
  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    username = var.github_owner
    password = var.github_token
  }

  depends_on = [
    kubectl_manifest.flux_install
  ]
}
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
  for_each  = data.kubectl_file_documents.flux_install.manifests
  yaml_body = each.value
}

data "flux_sync" "main" {
  target_path = var.target_path
  url         = github_repository.main.http_clone_url
}

data "kubectl_file_documents" "flux_sync" {
  content = data.flux_sync.main.content
}

resource "kubectl_manifest" "flux_sync" {
  for_each   = data.kubectl_file_documents.flux_sync.manifests
  yaml_body = each.value

  depends_on = [
    kubectl_manifest.flux_install
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

data "flux_install" "main" {
  target_path = var.target_path
}

resource "kubernetes_namespace" "flux_system" {
  depends_on = [
    module.eks
  ]
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

data "kubectl_file_documents" "apply" {
  content = data.flux_install.main.content
}

resource "kubectl_manifest" "apply" {
  for_each   = { for v in local.apply : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system]
  yaml_body = each.value
}

data "flux_sync" "main" {
  target_path = var.target_path
  url         = data.github_repository.main.http_clone_url
}

data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}

resource "kubectl_manifest" "sync" {
  for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system]
  yaml_body = each.value
}

resource "kubernetes_secret" "main" {
  depends_on = [kubectl_manifest.apply]

  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    username = var.github_owner
    password = var.github_token
  }
}
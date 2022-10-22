locals {
  cluster_name       = "${var.cluster_name_prefix}-${random_uuid.eks_name.result}"
  availability_zones = length(var.availability_zones) == 0 ? data.aws_availability_zones.available.names : var.availability_zones
  custom_overrides = {
    "datadog.apiKey" = var.datadog_api_key
  }
  flux_install = [ for v in data.kubectl_file_documents.flux_install.documents : {
      data: yamldecode(v)
      content: v
    }
  ]
  flux_sync = [ for v in data.kubectl_file_documents.flux_sync.documents : {
      data: yamldecode(v)
      content: v
    }
  ]
}

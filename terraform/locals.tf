locals {
  cluster_name       = "${var.cluster_name_prefix}-${random_uuid.eks_name.result}"
  availability_zones = length(var.availability_zones) == 0 ? data.aws_availability_zones.available.names : var.availability_zones
  custom_overrides = {
    "extraArgs" = format("{%s}", join(",", ["--insecure"]))
    "datadog.apiKey" = var.DATADOG_API_KEY
  }
}

locals {
  cluster_name       = "${var.cluster_name_prefix}-${random_uuid.eks_name.result}"
  availability_zones = length(var.availability_zones) == 0 ? data.aws_availability_zones.available.names : var.availability_zones
  custom_overrides = {
    "server.extraArgs" = format("{%s}", join(",", ["--insecure", "--auth-mode=server"]))
    "datadog.apiKey" = var.DATADOG_API_KEY
  }
}

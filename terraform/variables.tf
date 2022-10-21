variable "cluster_name_prefix" {
  description = "Name prefix of the EKS cluster"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "List of the desired availability zones"
  type        = list(string)
  default     = []
}

variable "DATADOG_API_KEY" {
    type        = string
    description = "Datadog API key"
}

variable "node_groups" {
  description = "List of the desired node groups configuration"
  type = map(object({
    node_group_name          = string
    node_group_instance_type = string
    node_group_ami_type      = string
    desired_worker_nodes     = number
    max_worker_nodes         = number
    min_worker_nodes         = number
    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
}

variable "helm_charts" {
  description = "List of the desired Helm charts configuration"
  type = map(object({
    name       = string
    namespace  = string
    repository = string
    chart      = string
    custom_overrides = list(object({
      name = string
    }))
    overrides = list(object({
      name  = string
      value = string
    }))
  }))
}

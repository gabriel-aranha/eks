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

variable "datadog_api_key" {
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

variable "github_owner" {
  type        = string
  description = "Github owner"
}

variable "github_token" {
  type        = string
  description = "Github token"
}

variable "repository_name" {
  type        = string
  default     = "my-flux-repo"
  description = "Github repository name"
}

variable "repository_visibility" {
  type        = string
  default     = "private"
  description = "How visible is the github repo"
}

variable "branch" {
  type        = string
  default     = "main"
  description = "Branch name"
}

variable "target_path" {
  type        = string
  default     = "my-cluster"
  description = "Flux sync target path"
}

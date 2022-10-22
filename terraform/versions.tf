terraform {
  backend "s3" {
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    helm = {
      source = "hashicorp/helm"
    }
    github = {
      source  = "integrations/github"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
    flux = {
      source  = "fluxcd/flux"
    }
  }
}

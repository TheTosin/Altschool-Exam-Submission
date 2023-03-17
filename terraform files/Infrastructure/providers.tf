#
# Provider Configuration
#

provider "aws" {
  region     = "us-west-1"
  version    = ">= 4.57.0"
  access_key = "AKIA4YJOBHOEUUN6OPZQ"
  secret_key = "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" 
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}


#
# Provider Configuration
#

provider "aws" {
  region     = "us-west-1"
  version    = ">= 4.57.0"
  access_key = "AKIA4YJOBHOE54FGOW5I"
  secret_key = "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" 
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


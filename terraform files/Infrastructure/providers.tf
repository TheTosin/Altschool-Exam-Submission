#
# Provider Configuration
#

provider "aws" {
  region     = "us-east-1"
   access_key = "AKIA4YJOBHOEUUN6OPZQ"
   secret_key = "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"
}

# Kubectl Terraform provider

terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

# Terraform Cloud Eks Workspace

 terraform {
   cloud {
     organization = "oluwatosin"

     workspaces {
       name = "infrastructure"
     }
   }
 }

# Kubernetes provider configuration

provider "kubernetes" {
  host                   = aws_Altschool_cluster.Altschool-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_Altschool_cluster.Altschool-cluster.certificate_authority[0].data)
  version          = "2.16.1"

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_Altschool_cluster.Altschool-cluster.name]
    command     = "aws"
  }
}

# Kubectl provider configuration

provider "kubectl" {
  host                   = aws_eks_cluster.eks-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_Altschool_cluster.Altschool-cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_Altschool_cluster.Altschool-cluster.name]
    command     = "aws"
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


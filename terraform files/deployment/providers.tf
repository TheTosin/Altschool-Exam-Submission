#
# Provider Configuration
#

provider "aws" {
  region     = "us-east-1"
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

#  Terraform Cloud Eks Workspace

 terraform {
   cloud {
     organization = "Oluwatosin"

     workspaces {
       name = "deployment"
     }
   }
 }

# Using these data sources allows the configuration to be
# generic for any region.

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

# Kubernetes provider configuration

# Retrieve eks cluster using data source

data "aws_eks_cluster" "Altschool-cluster" {
  name = "Altschool-cluster"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.Altschool-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.Altschool-cluster.certificate_authority[0].data)
  version          = "2.16.1"

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.Altschool-cluster.name]
    command     = "aws"
  }
}

# Kubectl provider configuration

provider "kubectl" {
  host                   = data.aws_eks_cluster.Altschool-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.Altschool-cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.Altschool-cluster.name]
    command     = "aws"
  }
}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}

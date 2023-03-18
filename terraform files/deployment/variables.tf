variable "cluster_name" {
  default = "Altschool-cluster"
  type    = string
}

variable "application-name" {
  default = "kubernetes"
}

variable "app" {
  type        = string
  description = "Name of application"
  default     = "portfolio"
}

variable "region" {
  default = "us-east-1"
}

variable "image" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "Oluwatosin/portfolio:1.0"
}

variable "mysql-password" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "my_db_password"
}

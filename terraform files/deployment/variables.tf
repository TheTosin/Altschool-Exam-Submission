variable "cluster" {
  default = "Altschool-cluster"
}

variable "app" {
  type        = string
  description = "Name of application"
  default     = "userprofile"
}

variable "region" {
  default = "us-east-1"
}

variable "image" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "myapp/userprofile:1.0"
}

variable "mysql-password" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "my_db_password"

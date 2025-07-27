variable "vpc_cidr" {
  type = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_subnet_1_cidr" {
  type        = string
  description = "CIDR block for private subnet 1"
}

variable "private_subnet_2_cidr" {
  type        = string
  description = "CIDR block for private subnet 2"
}

variable "ecr_repo_auth" {
  description = "ECR repo URL for auth image"
  type        = string
}

variable "alert_email" {
  description = "Email to receive SNS alerts"
  type        = string
}


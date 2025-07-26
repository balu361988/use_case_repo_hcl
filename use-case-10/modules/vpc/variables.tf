variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}


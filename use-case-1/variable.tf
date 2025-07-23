variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_a_cidr" {
  description = "CIDR block for subnet A"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR block for subnet B"
  type        = string
}

variable "subnet_c_cidr" {
  description = "CIDR block for subnet C"
  type        = string
}

variable "az_a" {
  description = "Availability zone A"
  type        = string
}

variable "az_b" {
  description = "Availability zone B"
  type        = string
}

variable "az_c" {
  description = "Availability zone C"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}


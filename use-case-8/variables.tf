variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
variable "environment" {
  description = "The Environment we are using"
  type = string
}
variable "pub_sub_count" {
  description = "Number of public subnets"
  type        = number
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "patient_repo_uri" {
    description = "The Patient image repo URL"
    type = string
}
variable "appointment_repo_uri" {
description = "The appointment image repo URL"
type = string
}

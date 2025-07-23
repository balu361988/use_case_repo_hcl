variable "environment" {
  description = "The Environment we are using"
  type        = string
}

variable "private_subnet_ids" {
  description = "The private subnet_ID"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "patient_repo_uri" {
  description = "The Patient image repo URL"
  type        = string
}

variable "appointment_repo_uri" {
  description = "The Appointment image repo URL"
  type        = string
}

variable "alb_sg_id" {
  description = "The ALB security group ID"
  type        = string
}

variable "patient_target_group_arn" {
  description = "Target group ARN for patient service"
  type        = string
}

variable "appointment_target_group_arn" {
  description = "Target group ARN for appointment service"
  type        = string
}

variable "patient_listener_rule_depends_on" {
  description = "Dependency placeholder for patient listener rule"
  type        = any
}

variable "appointment_listener_rule_depends_on" {
  description = "Dependency placeholder for appointment listener rule"
  type        = any
}

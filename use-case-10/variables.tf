variable "aws_region" {}
variable "vpc_cidr" {}
variable "subnet1_cidr" {}
variable "subnet2_cidr" {}
variable "az1" {}
variable "az2" {}
variable "alb_sg_id" {}
variable "service_sg_id" {}
variable "patient_repo" {
  type        = string
  description = "ECR repo name for patient service"
  default     = "patient-service"
}

variable "appointment_repo" {
  type        = string
  description = "ECR repo name for appointment service"
  default     = "appointment-service"
}



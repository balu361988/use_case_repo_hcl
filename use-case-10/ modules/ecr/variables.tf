variable "patient_repo" {
  description = "ECR repo name for patient service"
  type        = string
  default     = "patient-service"
}

variable "appointment_repo" {
  description = "ECR repo name for appointment service"
  type        = string
  default     = "appointment-service"
}

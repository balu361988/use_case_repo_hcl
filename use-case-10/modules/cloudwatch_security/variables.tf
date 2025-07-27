variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}


variable "alert_email" {
  description = "Email to receive CloudWatch alert notifications"
  type        = string
}


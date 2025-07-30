variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "notification_email" {
  description = "Email address to receive login alerts"
  type        = string
}

variable "bucket_name" {
  description = "Base name for CloudTrail log S3 bucket (unique suffix will be added)"
  type        = string
}

variable "trail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
}

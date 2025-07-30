variable "bucket_name" {
  description = "Base name of the S3 bucket for storing CloudTrail logs (a random suffix will be added)"
  type        = string
}

variable "trail_name" {
  description = "Name of the CloudTrail"
  type        = string
}

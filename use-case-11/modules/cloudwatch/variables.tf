variable "log_group_name" {
  description = "Name of the CloudWatch Log Group"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS Topic ARN for alarm notifications"
  type        = string
}

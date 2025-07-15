variable "rule_name" {
  type        = string
  description = "Name of CloudWatch rule"
}

variable "schedule_expression" {
  type        = string
  description = "Cron expression to trigger Lambda"
}

variable "lambda_function_name" {
  type        = string
  description = "Lambda function name"
}

variable "lambda_function_arn" {
  type        = string
  description = "Lambda function ARN"
}


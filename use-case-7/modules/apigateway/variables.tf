variable "api_name" {
  description = "Name of the API Gateway HTTP API"
  type        = string
}

variable "lambda_function_arn" {
  description = "Lambda function ARN to integrate with API Gateway"
  type        = string
}

variable "lambda_function_name" {
  type = string
}

variable "tags" {
  description = "Tags for API Gateway resources"
  type        = map(string)
  default     = {
    Project = "use-case-7"
  }
}


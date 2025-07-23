variable "role_name" {
  description = "Name of the IAM role to be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to IAM role"
  type        = map(string)
  default     = {
    Project = "use-case-7"
  }
}


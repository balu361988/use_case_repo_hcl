variable "env" {
  description = "Environment"
  type        = string
}

variable "worker_node_policy_arns" {
  description = "List of IAM policy ARNs to attach to EKS worker node role"
  type        = list(string)
}


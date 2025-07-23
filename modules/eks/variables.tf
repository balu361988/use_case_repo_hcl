variable "env" {
  description = "Environment name"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS control plane"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS node group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs (public or private) for EKS and nodes"
  type        = list(string)
}


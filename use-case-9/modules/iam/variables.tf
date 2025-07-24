variable "env" {
  description = "Environment"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs (public or private) for EKS and nodes"
  type        = list(string)
}

variable "worker_node_policy_arns" {
  description = "List of IAM policy ARNs to attach to EKS worker node role"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]
}

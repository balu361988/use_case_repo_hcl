variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "task_execution_role_arn" {
  type = string
}

variable "ecr_repo_frontend" {
  type = string
}

variable "ecr_repo_backend" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "tg_frontend_arn" {
  type = string
}

variable "tg_backend_arn" {
  type = string
}

variable "alb_listener_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecr_repo_auth" {
  description = "ECR repository URL for auth service"
  type        = string
}

variable "tg_auth_arn" {
  description = "Target group ARN for auth service"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN for auth container"
  type        = string
}

variable "auth_listener_rule_depends_on" {
  description = "Dependency on listener rule for auth service"
  type        = any
}

variable "cluster_id" {
  description = "ECS Cluster ID"
  type        = string
}

variable "ecs_security_group" {
  description = "Security group for ECS service"
  type        = string
}


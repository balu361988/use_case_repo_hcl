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


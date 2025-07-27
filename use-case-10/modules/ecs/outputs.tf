output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks_sg.id
}

output "auth_task_arn" {
  value = aws_ecs_task_definition.auth.arn
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_tasks_sg.id
}


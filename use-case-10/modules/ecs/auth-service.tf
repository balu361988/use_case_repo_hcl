resource "aws_ecs_service" "auth" {
  name            = "${var.environment}-auth-svc"
  cluster         = var.cluster_id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.auth.arn
  desired_count   = 1

  network_configuration {
    subnets          = var.private_subnet_ids
    assign_public_ip = false
    security_groups  = [var.ecs_security_group]
  }

  load_balancer {
    target_group_arn = var.tg_auth_arn
    container_name   = "auth"
    container_port   = 3002
  }

  depends_on = [var.auth_listener_rule_depends_on]
}


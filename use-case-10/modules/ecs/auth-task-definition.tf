resource "aws_ecs_task_definition" "auth" {
  family                   = "${var.environment}-auth-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
  name  = "auth"
  image = "${var.ecr_repo_auth}:latest"
  portMappings = [{
    containerPort = 3002
    hostPort      = 3002
    protocol      = "tcp"
  }]
  logConfiguration = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = "/ecs/${var.environment}-auth"
      awslogs-region        = "ap-south-1"
      awslogs-stream-prefix = "ecs"
    }
  }
}])

}

resource "aws_cloudwatch_log_group" "auth" {
  name              = "/ecs/${var.environment}-auth"
  retention_in_days = 7

  tags = {
    Environment = var.environment
  }
}


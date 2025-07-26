resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-ecs-cluster"
}

resource "aws_security_group" "ecs_tasks_sg" {
  name        = "${var.environment}-ecs-tasks-sg"
  vpc_id      = var.vpc_id
  description = "Allow traffic from ALB to ECS tasks"

  ingress {
    from_port       = 3000
    to_port         = 3001
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-ecs-sg"
  }
}


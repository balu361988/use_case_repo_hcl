resource "aws_ecs_cluster" "main" {
  name = "uc10-cluster"
}

resource "aws_ecs_task_definition" "patient" {
  family                   = "patient-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name  = "patient"
    image = var.patient_image
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

resource "aws_ecs_task_definition" "appointment" {
  family                   = "appointment-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name  = "appointment"
    image = var.appointment_image
    portMappings = [{
      containerPort = 3001
      hostPort      = 3001
    }]
  }])
}

resource "aws_ecs_service" "patient" {
  name            = "patient-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.patient.arn
  desired_count   = 1

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = true
    security_groups = [var.service_sg_id]
  }

  load_balancer {
    target_group_arn = var.patient_target_group_arn
    container_name   = "patient"
    container_port   = 3000
  }

  depends_on = [aws_ecs_task_definition.patient]
}

resource "aws_ecs_service" "appointment" {
  name            = "appointment-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.appointment.arn
  desired_count   = 1

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = true
    security_groups = [var.service_sg_id]
  }

  load_balancer {
    target_group_arn = var.appointment_target_group_arn
    container_name   = "appointment"
    container_port   = 3001
  }

  depends_on = [aws_ecs_task_definition.appointment]
}

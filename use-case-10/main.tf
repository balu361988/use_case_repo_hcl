module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  region               = var.region
  environment          = var.environment
}

module "alb" {
  source               = "./modules/alb"
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  alb_security_group_id = aws_security_group.alb_sg.id
  environment          = var.environment
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-alb-sg"
  description = "Allow HTTP traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-alb-sg"
  }
}

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
}

module "ecr" {
  source      = "./modules/ecr"
  environment = var.environment
}

module "ecs" {
  source     = "./modules/ecs"
  vpc_id     = module.vpc.vpc_id
  alb_sg_id  = aws_security_group.alb_sg.id
  environment = var.environment
}


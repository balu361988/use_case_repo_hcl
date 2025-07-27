provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  region                = var.region
  environment           = var.environment
}

module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = aws_security_group.alb_sg.id
  environment           = var.environment
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
  source                        = "./modules/ecs"
  vpc_id                        = module.vpc.vpc_id
  alb_sg_id                     = aws_security_group.alb_sg.id
  public_subnet_ids             = module.vpc.public_subnet_ids
  private_subnet_ids            = module.vpc.private_subnet_ids
  task_execution_role_arn       = module.iam.ecs_task_execution_role_arn
  ecr_repo_frontend             = module.ecr.frontend_repo_url
  ecr_repo_backend              = module.ecr.backend_repo_url
  ecr_repo_auth                 = var.ecr_repo_auth
  tg_frontend_arn               = module.alb.tg_frontend_arn
  tg_backend_arn                = module.alb.tg_backend_arn
  tg_auth_arn                   = module.alb.tg_auth_arn
  alb_listener_arn              = module.alb.alb_listener_arn
  environment                   = var.environment
  execution_role_arn            = module.iam.ecs_task_execution_role_arn
  auth_listener_rule_depends_on = module.alb.auth_listener_rule_depends_on
  cluster_id                    = module.ecs.ecs_cluster_id
  ecs_security_group            = module.ecs.ecs_sg_id

}

module "cloudwatch_security" {
  source      = "./modules/cloudwatch_security"
  environment = var.environment
  alert_email = var.alert_email
}




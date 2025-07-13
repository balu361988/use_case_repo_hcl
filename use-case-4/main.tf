provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "ec2" {
  source         = "./modules/ec2"
  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_ids[0]
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  security_group_id  = module.security_group.ec2_sg_id
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  # You CANNOT reference EC2 instance_id here directly — that causes a dependency cycle.
  # So instead, configure the ALB target group to use tags or simpler attachment logic
  # OR restructure this if absolutely needed.
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  project_name  = var.project_name
}


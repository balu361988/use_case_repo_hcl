module "vpc" {
  source          = "./modules/vpc"
  env             = var.env
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  region          = var.region
}

module "security_group" {
  source     = "./modules/security_group"
  env        = var.env
  vpc_id     = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  env               = var.env
  public_subnet_ids = module.vpc.public_subnet_ids
  web_sg_id         = module.security_group.web_sg_id
  instance_type     = var.instance_type
}

module "alb" {
  source         = "./modules/alb"
  subnet_ids     = module.vpc.public_subnet_ids
  vpc_id         = module.vpc.vpc_id
  instance_a_id  = module.ec2.instance_a_id[0]
}


provider "aws" {
  region = var.aws_region
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source         = "./modules/vpc"
  cidr_block     = var.vpc_cidr
  subnet1_cidr   = var.subnet1_cidr
  subnet2_cidr   = var.subnet2_cidr
  az1            = var.az1
  az2            = var.az2
}

module "ecr" {
  source = "./modules/ecr"
}

module "iam" {
  source = "./modules/iam"
}

module "alb" {
  source     = "./modules/alb"
  subnet_ids = module.vpc.subnet_ids
  alb_sg_id  = var.alb_sg_id
  vpc_id     = module.vpc.vpc_id
}

module "ecs" {
  source                      = "./modules/ecs"
  execution_role_arn         = module.iam.ecs_task_execution_role_arn
  patient_image              = "${module.ecr.ecr_patient_url}:latest"
  appointment_image          = "${module.ecr.ecr_appointment_url}:latest"
  subnet_ids                 = module.vpc.subnet_ids
  service_sg_id              = var.service_sg_id
  patient_target_group_arn   = module.alb.patient_target_group_arn
  appointment_target_group_arn = module.alb.appointment_target_group_arn
}


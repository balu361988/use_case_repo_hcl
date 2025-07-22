
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  pub_sub_count  = var.pub_sub_count
  priv_sub_count = var.priv_sub_count
  #nat_count      = var.nat_count
}
module "alb" {
  source = "./modules/alb"
  public_subnet_ids = module.vpc.public_subnet_ids
  environment = var.environment
  vpc_id = module.vpc.vpc_id
}
module "ecs" {
  source = "./modules/ecs"

  environment                        = var.environment
  vpc_id                             = var.vpc_id
  alb_sg_id                          = module.alb.alb_sg_id
  private_subnet_ids                 = var.private_subnet_ids
  patient_repo_uri                   = var.patient_repo_uri
  appointment_repo_uri              = var.appointment_repo_uri
  patient_target_group_arn          = module.alb.patient_target_group_arn
  appointment_target_group_arn      = module.alb.appointment_target_group_arn
  patient_listener_rule_depends_on  = module.alb.patient_listener_rule_depends_on
  appointment_listener_rule_depends_on = module.alb.appointment_listener_rule_depends_on
}

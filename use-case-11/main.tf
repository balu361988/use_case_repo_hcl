module "cloudtrail" {
  source      = "./modules/cloudtrail"
  bucket_name = var.bucket_name        # Just the base name, suffix is added inside module
  trail_name  = var.trail_name
}

module "sns" {
  source = "./modules/sns"
  email  = var.notification_email
}

module "cloudwatch" {
  source         = "./modules/cloudwatch"
  log_group_name = module.cloudtrail.log_group_name
  sns_topic_arn  = module.sns.alerts_topic_arn
}

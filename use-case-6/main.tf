module "role" {
  source    = "./modules/role"
  role_name = "start-ec2-lambda-role"
}

module "lambda_start" {
  source           = "./modules/lambda/start"
  lambda_role_arn  = module.role.role_arn
  lambda_role_name = module.role.role_name
}

module "scheduler" {
  source = "./modules/scheduler"

  rule_name            = "start-ec2-on-schedule"
  schedule_expression  = "rate(2 minutes)"
  lambda_function_name = module.lambda_start.start_lambda_function_name
  lambda_function_arn  = module.lambda_start.start_lambda_function_arn
}


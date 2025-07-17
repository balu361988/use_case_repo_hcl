provider "aws" {
  region = "ap-southeast-2"
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "hello-lambda"
  tags = {
    Environment = "dev"
    Project     = "use-case-7"
  }
}

module "iam" {
  source    = "./modules/iam"
  role_name = "hello-lambda-role"
  tags = {
    Environment = "dev"
    Project     = "use-case-7"
  }
}

module "lambda" {
  source                = "./modules/lambda"
  function_name         = "hello-lambda-function"
  image_uri             = "427521931204.dkr.ecr.ap-southeast-2.amazonaws.com/hello-lambda:latest"
  lambda_role_arn       = module.iam.iam_role_arn
  memory_size           = 128
  timeout               = 10
  environment_variables = {
    ENV = "dev"
  }
  tags = {
    Environment = "dev"
    Project     = "use-case-7"
  }
}

module "apigateway" {
  source               = "./modules/apigateway"
  api_name             = "hello-lambda-function-API"
  lambda_function_arn  = module.lambda.lambda_function_arn
  lambda_function_name = module.lambda.lambda_function_name
  tags = {
    Environment = "dev"
    Project     = "use-case-7"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Project     = "use-case-7"
    Environment = "dev"
  }
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "api_gateway_url" {
  value = module.apigateway.api_endpoint
}


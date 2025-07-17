resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.lambda_role_arn
  package_type  = "Image"
  image_uri     = var.image_uri
  timeout       = 10
  memory_size   = 128

  environment {
    variables = var.environment_variables
  }
}


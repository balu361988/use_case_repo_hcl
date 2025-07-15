resource "aws_lambda_function" "start_ec2" {
  filename         = "${path.module}/start_ec2.zip"
  function_name    = "start_ec2_instances"
  role             = var.lambda_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256("${path.module}/start_ec2.zip")
  timeout          = 10
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = var.lambda_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


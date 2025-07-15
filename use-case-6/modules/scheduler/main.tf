resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = var.rule_name
  description         = "Trigger Lambda to start EC2 on schedule"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "start-ec2-lambda"
  arn       = var.lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
}


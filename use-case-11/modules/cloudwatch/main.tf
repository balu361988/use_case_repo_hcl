resource "aws_cloudwatch_log_metric_filter" "console_login" {
  name           = "ConsoleLoginMetricFilter"
  log_group_name = var.log_group_name

  pattern = "{ $.eventName = \"ConsoleLogin\" && $.responseElements.ConsoleLogin = \"Success\" }"

  metric_transformation {
    name      = "SuccessfulConsoleLoginCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_login_alarm" {
  alarm_name          = "ConsoleLoginAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "SuccessfulConsoleLoginCount"
  namespace           = "CloudTrailMetrics"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Triggers when a successful AWS Console Login occurs"
  alarm_actions       = [var.sns_topic_arn]
}

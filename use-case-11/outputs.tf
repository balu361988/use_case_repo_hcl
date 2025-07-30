output "cloudtrail_log_group" {
  value = module.cloudtrail.log_group_name
}

output "sns_topic_arn" {
  value = module.sns.alerts_topic_arn
}

output "alarm_name" {
  value = module.cloudwatch.alarm_name
}

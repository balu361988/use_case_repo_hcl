output "log_group_name" {
  description = "CloudWatch Log Group name used by CloudTrail"
  value       = aws_cloudwatch_log_group.trail_logs.name
}

output "cloudtrail_role_arn" {
  description = "IAM Role ARN used by CloudTrail"
  value       = aws_iam_role.cloudtrail_role.arn
}

output "s3_bucket_name" {
  description = "S3 bucket name where CloudTrail logs are stored"
  value       = aws_s3_bucket.cloudtrail_logs.id
}

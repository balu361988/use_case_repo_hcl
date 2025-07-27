###########################################
# 0. Get Current Account ID
###########################################
data "aws_caller_identity" "current" {}

###########################################
# 1. S3 Bucket for CloudTrail logs
###########################################
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "trail_bucket" {
  bucket         = "${var.environment}-cloudtrail-bucket-${random_id.bucket_suffix.hex}"
  force_destroy  = true

  tags = {
    Name = "${var.environment}-cloudtrail-bucket"
  }
}

###########################################
# 1.b. S3 Bucket Policy for CloudTrail
###########################################
resource "aws_s3_bucket_policy" "trail_bucket_policy" {
  bucket = aws_s3_bucket.trail_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck",
        Effect    = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action    = "s3:GetBucketAcl",
        Resource  = aws_s3_bucket.trail_bucket.arn
      },
      {
        Sid       = "AWSCloudTrailWrite",
        Effect    = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action    = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource  = "${aws_s3_bucket.trail_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}


###########################################
# 2. CloudWatch Log Group for CloudTrail
###########################################
resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name = "/aws/cloudtrail/security"
}

###########################################
# 3. IAM Role for CloudTrail to publish logs
###########################################
resource "aws_iam_role" "cloudtrail_cloudwatch_role" {
  name = "cloudtrail-to-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "cloudtrail_logs_delivery" {
  name = "cloudtrail-logs-delivery"
  role = aws_iam_role.cloudtrail_cloudwatch_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogStream"
        ],
        Resource = "${aws_cloudwatch_log_group.cloudtrail_logs.arn}:*"
      }
    ]
  })
}

###########################################
# 4. IAM Role Policy Attachment
###########################################
resource "aws_iam_role_policy_attachment" "cloudtrail_logs_policy" {
  role       = aws_iam_role.cloudtrail_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudTrail_FullAccess"
}

###########################################
# 5. CloudTrail Setup
###########################################
resource "aws_cloudtrail" "security_trail" {
  name                          = "cloudwatch-security-trail"
  s3_bucket_name                = aws_s3_bucket.trail_bucket.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail_logs.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_cloudwatch_role.arn
}

###########################################
# 6. Metric Filter for Unauthorized API Calls
###########################################
resource "aws_cloudwatch_log_metric_filter" "unauthorized_api_calls" {
  name           = "unauthorized-api-calls"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"

  metric_transformation {
    name      = "UnauthorizedAPICallCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

###########################################
# 7. CloudWatch Alarm for Unauthorized API Calls
###########################################
resource "aws_cloudwatch_metric_alarm" "unauthorized_api_alarm" {
  alarm_name          = "${var.environment}-unauthorized-api-calls-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.unauthorized_api_calls.metric_transformation[0].name
  namespace           = "CloudTrailMetrics"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_description   = "Alarm for unauthorized API calls detected by CloudTrail"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.security_alerts.arn]

  tags = {
    Name = "${var.environment}-unauthorized-api-calls-alarm"
  }
}

###########################################
# 8. SNS Topic for Alerting
###########################################
resource "aws_sns_topic" "security_alerts" {
  name = "${var.environment}-security-alerts"
}

###########################################
# 9. SNS Email Subscription
###########################################
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}


resource "aws_iam_role" "lambda_exec_role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.role_name}-policy"
  description = "Policy for Lambda to Start EC2"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:StartInstances",
          "ec2:DescribeInstances"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}


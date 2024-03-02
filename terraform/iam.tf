# ----------------------
# IAM Role
# ----------------------
# ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
      },
    ],
  })
}
# SSM Read Policy
resource "aws_iam_policy" "ssm_read_policy" {
  name        = "ssm-read-policy"
  description = "Policy to allow reading SecureString parameters from SSM"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters",
          "kms:Decrypt" # SecureStringを復号
        ],
        Resource = [
          "arn:aws:ssm:ap-northeast-1:211125433381:parameter/${var.project}/${var.environment}/*"
        ]
      },
    ],
  })
}
resource "aws_iam_role_policy_attachment" "ssm_read_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ssm_read_policy.arn
}

# S3 Access Policy to ECS Task
resource "aws_iam_policy" "ecs_s3_access_policy" {
  name        = "${var.project}-${var.environment}-ecs-s3-access-policy"
  description = "Allows ECS tasks to access S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Effect = "Allow"
        Resource = "${aws_s3_bucket.s3_static_bucket.arn}/*"
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ecs_s3_access_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_s3_access_policy.arn
}

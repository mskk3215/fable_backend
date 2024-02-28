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
# ECS Task Execution Role Policy Attachment
resource "aws_iam_role_policy_attachment" "ssm_read_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ssm_read_policy.arn
}

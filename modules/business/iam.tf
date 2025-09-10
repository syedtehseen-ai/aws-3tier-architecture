# ---------- IAM role for Lambda ----------
# Trust Role Policy
data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
# Role with assume role policy attached
resource "aws_iam_role" "lambda_role" {
  name               = var.lambda_exec_role
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

# Inline Policy with Role attached and perm for log groups and DynamoDB svc
resource "aws_iam_role_policy" "lambda_policy" {
  name = var.lambda_exec_policy
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:UpdateItem"
        ],
        Resource = var.dynamo_table_arn
      }
    ]
  })
}
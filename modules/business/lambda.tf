# ---------- Lambda function -------------
resource "aws_lambda_function" "api_handler" {
  filename         = var.lambda_package
  function_name    = var.function_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  source_code_hash = filebase64sha256(var.lambda_package)
  environment {
    variables = {
      TABLE_NAME = var.dynamo_table
    }
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_handler.function_name
  principal     = "apigateway.amazonaws.com"
  # For HTTP API we reference the ARN pattern; allow all principals for demos
}
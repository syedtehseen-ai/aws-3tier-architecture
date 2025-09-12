# ---------- API Gateway HTTP API ----------
resource "aws_apigatewayv2_api" "http_api" {
  name          = var.apigw
  protocol_type = "HTTP"
  cors_configuration {
  allow_origins = ["http://${var.website_endpoint}"]
  allow_methods = ["GET", "POST", "OPTIONS"]
  allow_headers = ["authorization", "content-type"]
}

}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.api_handler.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

# Route for GET /items and POST /items
resource "aws_apigatewayv2_route" "items_get" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /items"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
  authorization_type = "NONE"
}

resource "aws_apigatewayv2_route" "items_post" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /items"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
  authorizer_id = aws_apigatewayv2_authorizer.cognito_jwt.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}


# ---------- Authorizer: HTTP API JWT that uses Cognito ----------
resource "aws_apigatewayv2_authorizer" "cognito_jwt" {
  api_id         = aws_apigatewayv2_api.http_api.id
  authorizer_type = "JWT"
  name           = var.cognito_jwt
  identity_sources = ["$request.header.Authorization"]

  jwt_configuration {
    issuer  = "https://cognito-idp.${var.region}.amazonaws.com/${var.cognito_user_pool_id}"
    audience = [var.cognito_user_pool_client_id]
  }
}

# attach authorizer to a route (example on GET /items)
resource "aws_apigatewayv2_route" "items_get_auth" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /items-auth"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
  authorizer_id = aws_apigatewayv2_authorizer.cognito_jwt.id
  authorization_type = "JWT"
}
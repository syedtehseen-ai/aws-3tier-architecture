# ---------- Cognito User Pool & client ----------

resource "aws_cognito_user_pool" "pool" {
  name = "${var.project_name}-user-pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.project_name}-client"
  user_pool_id = aws_cognito_user_pool.pool.id
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
  prevent_user_existence_errors = "ENABLED"
  generate_secret = false
}
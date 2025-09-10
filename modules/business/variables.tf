variable "apigw" {
  type = string
}

variable "lambda_package" {
  description = "Path to Lambda deployment package"
  type        = string
}

variable "function_name" {
  description = "Path to Lambda deployment package"
  type        = string
}

variable "lambda_exec_role" {
  description = "lambda Execution Role"
  type = string
}

variable "lambda_exec_policy" {
  description = "lambda Execution Role"
  type = string
}


variable "cognito_jwt" {
  description = "Name of the JWT Authorizer"
  type = string
}

variable "region" {
  type = string
}

variable "cognito_user_pool_id"{
  description = "Cognito Pool ID"
  type = string
}

variable "cognito_user_pool_client_id"{
  description = "Cognito Pool Client ID"
  type = string
}

variable "dynamo_table_arn"{
  description = "DynamoDB table ARN"
  type = string
}
variable "dynamo_table" {
  description = "Name of the DynamoDB Table"
  type        = string
}
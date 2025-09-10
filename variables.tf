variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}

variable "project_name" {
  type = string
}

variable "apigw" {
  type = string
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


variable "dynamo_table" {
  description = "Name of the DynamoDB Table"
  type        = string
}

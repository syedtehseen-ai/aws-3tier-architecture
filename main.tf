
############################################################
#  Presentation Tier Module
############################################################
module "presentation" {
  source         = "./modules/presentation"
  tags = var.tags
  project_name = var.project_name
  static_indexpage = "${path.root}/App/static/index.html"

}


############################################################
#  Business / Application Tier Module
############################################################
module "business" {
  source         = "./modules/business"
  apigw = var.apigw
  lambda_package = "${path.root}/App/lambda/function.zip" # path.root- absolute path to the root where tf resources exist
  function_name = var.function_name
  lambda_exec_role = var.lambda_exec_role
  lambda_exec_policy = var.lambda_exec_policy
  website_endpoint = module.presentation.website_endpoint
  dynamo_table = var.dynamo_table
  dynamo_table_arn = module.data.dynamo_table_arn
  cognito_jwt = var.cognito_jwt
  region = var.region
  cognito_user_pool_id = module.presentation.cognito_user_pool_id
  cognito_user_pool_client_id = module.presentation.cognito_user_pool_client_id
}


############################################################
#  Data / Storage Tier Module
############################################################
module "data" {
  source         = "./modules/data"
  dynamo_table = var.dynamo_table
}
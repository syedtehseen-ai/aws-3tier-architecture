# ---------- DynamoDB ----------
resource "aws_dynamodb_table" "items" {
  name         = var.dynamo_table
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
}
terraform {
  backend "s3" {
    bucket         = "tehseen-ai-tf"
    key            = "dev/3-tier-arch/nw-infra.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
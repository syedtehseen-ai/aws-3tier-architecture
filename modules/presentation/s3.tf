# To create a random ID for uniqueness of the bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# ------ S3 bucket for static site ----------
resource "aws_s3_bucket" "site" {
  bucket = "poc-serverless-site-${random_id.bucket_suffix.hex}"
  tags = var.tags
  force_destroy = true

}

# upload the object to the s3 bucket

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.site.id
  key    = "index.html"
  source = var.static_indexpage   # you can create a tiny index file
  content_type = "text/html"
}


resource "aws_s3_bucket_ownership_controls" "site" {
  bucket = aws_s3_bucket.site.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
# public hosting
resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "site" {
  depends_on = [aws_s3_bucket_ownership_controls.site, aws_s3_bucket_public_access_block.site]
  bucket     = aws_s3_bucket.site.id
  acl        = "public-read"
}

# static website configuration
resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

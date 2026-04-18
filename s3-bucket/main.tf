provider "aws" {
  region = "us-east-1"

}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-s3-bucket-state-file"
  lifecycle{
   prevent_destroy = true

}
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.terraform-state.id

  rule {
   apply_server_side_encryption_by_default {
       sse_algorithm     = "AES256"

}
}
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

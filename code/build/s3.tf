provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dev_s3" {
  bucket_prefix = "dev-"
  #checkov:skip=CKV_AWS_20:The bucket is a public static content host
  #checkov:skip=CKV_AWS_18:This is a test we are not going to enable logging on this bucket.
  #checkov:skip=CKV2_AWS_61:This is a test we are not going to enable logging on this bucket.

  tags = {
    Environment          = "Dev"
    yor_name             = "dev_s3"
    yor_trace            = "9dcfc222-a038-48ac-9e52-3e494f9e88c5"
    git_commit           = "3affd5c996f5a732cca5f2096eaf5ee77b4b9b22"
    git_file             = "code/build/s3.tf"
    git_last_modified_at = "2025-01-21 19:22:24"
    git_last_modified_by = "khalifahks@kohirens.com"
    git_modifiers        = "khalifahks"
    git_org              = "khalifahks"
    git_repo             = "prisma-cloud-devsecops-workshop"
  }
}

resource "aws_s3_bucket_ownership_controls" "dev_s3" {
  bucket = aws_s3_bucket.dev_s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "dev_s3" {
  bucket = aws_s3_bucket.dev_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "dev_s3" {
  depends_on = [aws_s3_bucket_ownership_controls.dev_s3]

  bucket = aws_s3_bucket.dev_s3.id
  acl    = "private"
}

resource "random_string" "random" {
  length  = 8
  lower   = true
  upper   = false
  special = false
  numeric = false
}

resource "aws_s3_bucket" "kops_bucket" {
  provider = aws.us-east-1
  bucket   = "${var.project_name}-${random_string.random.result}-kops-bucket"
}

resource "aws_s3_bucket_public_access_block" "kops_ab" {
  provider = aws.us-east-1
  bucket   = aws_s3_bucket.kops_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "kops_oc" {
  provider = aws.us-east-1
  bucket   = aws_s3_bucket.kops_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "kops_acl" {
  provider = aws.us-east-1
  bucket = aws_s3_bucket.kops_bucket.id
  acl    = "public-read"
  depends_on = [
    aws_s3_bucket_public_access_block.kops_ab,
    aws_s3_bucket_ownership_controls.kops_oc,
  ]
}

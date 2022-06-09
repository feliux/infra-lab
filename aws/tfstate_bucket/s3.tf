resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = var.tfstate.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning_tfstate" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = var.tfstate.versioning
  }
}

resource "aws_kms_key" "tfstate_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 30 # max days
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encrypted" {
  bucket = aws_s3_bucket.tfstate_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tfstate_key.arn
      sse_algorithm     = var.tfstate.sse_algorithm
    }
  }
}

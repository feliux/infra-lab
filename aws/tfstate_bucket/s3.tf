resource "aws_s3_bucket" "terraform_state" {
  bucket = var.tfstate.bucket_name
  versioning {
    enabled = var.tfstate.versioning
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.tfstate.sse_algorithm
      }
    }
  }
}

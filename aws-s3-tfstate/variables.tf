variable "region" {
  description = "Deployment Region"
  default     = "us-east-1"
}

variable "tfstate" {
  description = "Variables to store tfstate"
  default = {
    bucket_name   = "tfstate-random-A"
    versioning    = "Enabled"
    sse_algorithm = "aws:kms"
  }
}

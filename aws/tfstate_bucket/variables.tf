variable "region" {
  description = "Deployment Region"
  default     = "us-east-1"
}

variable "tfstate" {
  description = "Variables to store tfstate"
  default = {
    bucket_name = "terraform-ahdsbd"
    # buket_key = 
    versioning    = true
    sse_algorithm = "AES256"
  }
}

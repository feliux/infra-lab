terraform {
  required_providers {
    aws = {
      version = "4.67.0"
    }
  }
}

provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

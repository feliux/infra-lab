terraform {
  required_version = ">= 1.0.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.66.0"
    }
  }
}

provider "aws" {
  region = var.region
}

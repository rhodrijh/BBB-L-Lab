terraform {
  required_providers {
    aws = {
      version = "4.21.0"
    }
  }
  required_version = "~> 1.3.1"
}

provider "aws" {
  region = var.aws_region
}
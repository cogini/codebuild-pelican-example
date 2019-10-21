terraform {
  backend "s3" {
  }
  required_version = ">= 0.12"
}

provider "aws" {
  alias   = "cloudfront"
  region  = "us-east-1"
  version = "~> 2.0"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 2.0"
}

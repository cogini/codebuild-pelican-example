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

/**
 * Do not remove, this causes input prompts otherwise
 * >At this time it is required to write an explicit
 * >proxy configuration block even for default (un-aliased)
 * >provider configurations when they will be passed via
 * >an explicit providers block
 *
 * https://www.terraform.io/docs/modules/usage.html#passing-providers-explicitly
 * https://git.io/fh0qw
 */

provider "aws" {
  region  = var.aws_region
  version = "~> 2.0"
}

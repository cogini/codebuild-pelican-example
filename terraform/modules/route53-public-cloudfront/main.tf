# Create Route53 alias record for public domain pointing to CloudFront
# This creates records for example.com and www.example.com

data "terraform_remote_state" "route53" {
  backend = "s3"
  config = {
    bucket = var.remote_state_s3_bucket_name
    key    = "${var.remote_state_s3_key_prefix}/route53-public/terraform.tfstate"
    region = var.remote_state_s3_bucket_region
  }
}

data "terraform_remote_state" "cloudfront" {
  backend = "s3"
  config = {
    bucket = var.remote_state_s3_bucket_name
    key    = "${var.remote_state_s3_key_prefix}/cloudfront-public-web/terraform.tfstate"
    region = var.remote_state_s3_bucket_region
  }
}

# https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-values-alias.html
resource "aws_route53_record" "base" {
  zone_id = data.terraform_remote_state.route53.outputs.zone_id
  name    = var.public_domain
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.cf_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.cf_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "base-aaaa" {
  zone_id = data.terraform_remote_state.route53.outputs.zone_id
  name    = var.public_domain
  type    = "AAAA"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.cf_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.cf_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.terraform_remote_state.route53.outputs.zone_id
  name    = "www.${var.public_domain}"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.cf_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.cf_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www-aaaa" {
  zone_id = data.terraform_remote_state.route53.outputs.zone_id
  name    = "www.${var.public_domain}"
  type    = "AAAA"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.cf_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.cf_hosted_zone_id
    evaluate_target_health = true
  }
}

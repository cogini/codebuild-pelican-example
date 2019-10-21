# Create a certificate using Amazon Certificate Manager (ACM) with
# Route 53 DNS validation.

# Generates cert for the public domain and wildcard,
# e.g. example.com and *.example.com

# Generates a duplicate cert for CloudFront, which must be in us-east-1,
# assuming that there is already a public cert in a different region.

locals {
  domain = var.public_domain
}

data "aws_route53_zone" "selected" {
  name = local.domain
}

# https://www.terraform.io/docs/providers/aws/r/acm_certificate.html
resource "aws_acm_certificate" "default" {
  provider = aws.cloudfront

  domain_name               = local.domain
  subject_alternative_names = ["*.${local.domain}"]
  validation_method         = "DNS"

  tags = merge(
    {
      "Name"  = local.domain
      "org"   = var.org
      "app"   = var.app_name
      "env"   = var.env
      "owner" = var.owner
    },
    var.extra_tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  # count    = "${length(var.subject_alternative_names) + 1}"
  # count    = 2

  # If this is a secondary cert, then the DNS records are already created by the primary
  count = var.create_route53_records ? 1 : 0

  name    = aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_name"]
  type    = aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_type"]
  records = [aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_value"]]
  zone_id = data.aws_route53_zone.selected.zone_id
  ttl     = var.validation_record_ttl
}

resource "aws_acm_certificate_validation" "default" {
  provider        = aws.cloudfront
  certificate_arn = aws_acm_certificate.default.arn

  validation_record_fqdns = [
    aws_acm_certificate.default.domain_validation_options[0].resource_record_name,
  ]
}

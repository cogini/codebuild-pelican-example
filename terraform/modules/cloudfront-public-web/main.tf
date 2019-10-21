# Create CloudFront distribution for public website of app,
# built with a static site generator.

locals {
  aliases = (var.enable_acm_certificate || var.enable_iam_certificate) ? [var.public_domain, "${var.host_name}.${var.public_domain}"] : []
}

# Bucket with public website files
data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = var.remote_state_s3_bucket_name
    key    = "${var.remote_state_s3_key_prefix}/s3-${var.comp}/terraform.tfstate"
    region = var.remote_state_s3_bucket_region
  }
}

# Request logs bucket
data "terraform_remote_state" "s3-request-logs" {
  backend = "s3"
  config = {
    bucket = var.remote_state_s3_bucket_name
    key    = "${var.remote_state_s3_key_prefix}/s3-request-logs/terraform.tfstate"
    region = var.remote_state_s3_bucket_region
  }
}


# Lambda function to handle URL mapping, e.g. /about/ to /about/index.html
data "terraform_remote_state" "lambda-edge" {
  backend = "s3"
  config = {
    bucket = var.remote_state_s3_bucket_name
    key    = "${var.remote_state_s3_key_prefix}/lambda-edge/terraform.tfstate"
    region = var.remote_state_s3_bucket_region
  }
}

data "aws_caller_identity" "current" {
}

# Certificate managed by ACM
data "aws_acm_certificate" "host" {
  provider = aws.cloudfront
  count    = var.enable_acm_certificate ? 1 : 0
  domain   = var.public_domain
  statuses = ["ISSUED"]
}

# Certificate managed external to AWS, e.g. in China where ACM is not available
data "aws_iam_server_certificate" "host" {
  provider = aws.cloudfront
  count    = var.enable_iam_certificate ? 1 : 0
  name     = var.public_domain
  latest   = true
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "${var.app_name}-${var.env}-${var.comp}"
}

# Give CloudFront access to bucket where assets are stored
data "aws_iam_policy_document" "cloudfront" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${data.terraform_remote_state.s3.outputs.public_web_arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }

  statement {
    actions = ["s3:ListBucket"]
    resources = [data.terraform_remote_state.s3.outputs.public_web_arn]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = data.terraform_remote_state.s3.outputs.public_web_id
  policy = data.aws_iam_policy_document.cloudfront.json
}

# https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html
# https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_UpdateDistribution.html
resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = var.price_class

  default_root_object = "index.html"
  comment             = "${var.app_name} ${var.env} ${var.host_name}"

  # http_version = "http2"

  origin {
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
    origin_path = var.origin_path

    domain_name = data.terraform_remote_state.s3.outputs.public_web_bucket_regional_domain_name
    origin_id   = data.terraform_remote_state.s3.outputs.public_web_id
  }

  logging_config {
    bucket          = data.terraform_remote_state.s3-request-logs.outputs.request_logs_bucket_domain_name
    prefix          = "cloudfront/${var.host_name}"
    include_cookies = false
  }

  # ACM cert
  dynamic "viewer_certificate" {
    for_each = var.enable_acm_certificate ? list(1) : []

    content {
      acm_certificate_arn      = data.aws_acm_certificate.host[0].arn
      ssl_support_method       = "sni-only"
      minimum_protocol_version = "TLSv1"
    }
  }

  # IAM cert
  dynamic "viewer_certificate" {
    for_each = var.enable_iam_certificate ? list(1) : []

    content {
      acm_certificate_arn      = data.aws_aam_certificate.cert[0].arn
      ssl_support_method       = "sni-only"
      minimum_protocol_version = "TLSv1"
    }
  }

  # Default cert
  dynamic "viewer_certificate" {
    for_each = (var.enable_acm_certificate || var.enable_iam_certificate) ? [] : list(1)

    content {
      cloudfront_default_certificate = true
    }
  }

  aliases = local.aliases

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # custom_error_response {
  #   error_code    = 403
  #   response_code = 200
  #   response_page_path = "/index.html"
  # }

  # custom_error_response {
  #   error_code    = 404
  #   response_code = 200
  #   response_page_path = "/index.html"
  # }

  default_cache_behavior {
    # allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.terraform_remote_state.s3.outputs.public_web_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    # trusted_signers = [data.aws_caller_identity.current.account_id]

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = data.terraform_remote_state.lambda-edge.outputs.function_index_html_qualified_arn
      # include_body = false
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    compress               = var.compress
  }

  tags = merge(
    {
      "Name"  = "${var.host_name}.${var.public_domain}"
      "org"   = var.org
      "app"   = var.app_name
      "env"   = var.env
      "comp"  = var.comp
      "owner" = var.owner
    },
    var.extra_tags,
  )
}

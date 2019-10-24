# Set up S3 bucket for hosting public website

locals {
  name = var.name == "" ? "${var.org_unique}-${var.app_name}-${var.env}-${var.comp}" : var.name
}

resource "aws_s3_bucket" "this" {
  bucket = local.name

  # cors_rule {
  #   allowed_headers = var.cors_allowed_headers
  #   allowed_methods = var.cors_allowed_methods
  #   allowed_origins = var.cors_allowed_origins
  #   expose_headers  = var.cors_expose_headers
  #   max_age_seconds = var.cors_max_age_seconds
  # }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags = merge(
    {
      "org"   = var.org
      "app"   = var.app_name
      "env"   = var.env
      "comp"  = var.comp
      "owner" = var.owner
    },
    var.extra_tags,
  )

  force_destroy = var.force_destroy
}

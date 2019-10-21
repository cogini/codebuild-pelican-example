# Create S3 bucket for request logs from load balancer and CloudFront

resource "aws_s3_bucket" "request_logs" {
  bucket = "${var.org_unique}-${var.app_name}-${var.env}-request-logs"

  tags = merge(
    {
      "org"   = var.org
      "app"   = var.app_name
      "env"   = var.env
      "owner" = var.owner
    },
    var.extra_tags,
  )

  force_destroy = var.force_destroy
}

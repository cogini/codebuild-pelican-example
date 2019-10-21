output "cf_id" {
  value = aws_cloudfront_distribution.this.id
}

output "cf_arn" {
  value = aws_cloudfront_distribution.this.arn
}

output "cf_status" {
  value = aws_cloudfront_distribution.this.status
}

output "cf_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cf_etag" {
  value = aws_cloudfront_distribution.this.etag
}

output "cf_hosted_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

# output "cf_origin_access_identity" {
#   value = aws_cloudfront_origin_access_identity.this.
# }

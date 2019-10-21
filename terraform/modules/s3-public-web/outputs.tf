output "public_web_id" {
  description = "Public web bucket id"
  value       = aws_s3_bucket.this.id
}

output "public_web_arn" {
  description = "Public web bucket arn"
  value       = aws_s3_bucket.this.arn
}

output "public_web_bucket_domain_name" {
  description = "Public web bucket bucket_domain_name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "public_web_bucket_regional_domain_name" {
  description = "Public web bucket_regional_domain_name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

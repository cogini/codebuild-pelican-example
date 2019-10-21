output "request_logs_id" {
  description = "Request logs bucket id"
  value       = aws_s3_bucket.request_logs.id
}

output "request_logs_arn" {
  description = "Request logs ARN"
  value       = aws_s3_bucket.request_logs.arn
}

output "request_logs_bucket_domain_name" {
  description = "Request logs bucket_domain_name"
  value       = aws_s3_bucket.request_logs.bucket_domain_name
}

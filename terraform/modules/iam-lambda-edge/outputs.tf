output "lambda_edge_service_role_id" {
  description = "Lambda@Edge service role id"
  value       = aws_iam_role.lambda-edge.id
}

output "lambda_edge_service_role_arn" {
  description = "Lambda@Edge service role arn"
  value       = aws_iam_role.lambda-edge.arn
}

output "lambda_edge_service_role_name" {
  description = "Lambda@Edge service role name"
  value       = aws_iam_role.lambda-edge.name
}

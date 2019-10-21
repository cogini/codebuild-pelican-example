output "zone_id" {
  description = "The Hosted Zone ID"
  value       = aws_route53_zone.this.zone_id
}

output "name" {
  description = "The Hosted Zone name"
  value       = aws_route53_zone.this.name
}

output "name_servers" {
  description = "A list of name servers in associated (or default) delegation set"
  value       = aws_route53_zone.this.name_servers
}

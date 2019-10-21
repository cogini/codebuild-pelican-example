variable "create_route53_records" {
  description = "Whether to create Route53 records for validation. false for secondary cert, true for primary."
  default     = false
}

variable "validation_record_ttl" {
  description = "Route 53 time-to-live for validation records"
  default     = 60
}

variable "extra_tags" {
  description = "Extra tags to attach to the ACM certificate"
  default     = {}
}

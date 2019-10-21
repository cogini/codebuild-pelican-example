variable "comp" {
  description = "Part of the app, e.g. public-web"
}

variable "host_name" {
  description = "Host part, e.g. www for www.example.com"
  default     = "www"
}

variable "enable_acm_certificate" {
  description = "Use AWS Certificate Manager to manage cert"
  default     = false
}

variable "enable_iam_certificate" {
  description = "Use IAM to manage cert, exclusive to enable_acm_certificate"
  default     = false
}

variable "restrictions" {
  description = "Restrictions on CloudFront distribution"
  default = null
  # default = {
  #   geo_restriction = {
  #     restriction_type = "none"
  #   }
  # }
}

variable "price_class" {
  description = "Price class restrictions"
  # default     = "PriceClass_All" # PriceClass_All | PriceClass_200 | PriceClass_100
  default     = null
}

variable "origin_path" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath
  description = "Directory in S3 bucket CloudFront should read content from. Blank for root of bucket. Do not add a / at the end of the path."
  default     = ""
}

variable "default_ttl" {
  description = "Seconds before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header"
  default     = 3600
}

variable "min_ttl" {
  default = 0
}

variable "max_ttl" {
  default = 86400
}

variable "compress" {
  description = "Compress content for web requests that include Accept-Encoding: gzip in the request header"
  default     = true
}

variable "viewer_protocol_policy" {
  description = "allow-all, https-only, redirect-to-https"
  default = "allow-all"
  # default     = "redirect-to-https"
}

# variable "trigger_event_type" {
#   description = "Lambda@Edge trigger type: viewer-request, origin-request, viewer-response, origin-response"
#   default = "viewer-request"
# }

variable "extra_tags" {
  description = "A mapping of extra tags to assign to the resource"
  default     = {}
}

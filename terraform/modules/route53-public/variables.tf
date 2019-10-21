variable "force_destroy" {
  description = "Force destroy even if there are subdomains"
  default     = false
}

variable "extra_tags" {
  description = "A map of extra tags"
  default     = {}
}

variable "delegation_set_id" {
  description = "Public domain name for app"
  default     = ""
}

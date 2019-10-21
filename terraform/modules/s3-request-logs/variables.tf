variable "extra_tags" {
  description = "A map of extra tags"
  default     = {}
}

variable "force_destroy" {
  description = "Force destroy of bucket even if it's not empty"
  default     = false
}

variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "aws_region_acm" {
  description = "The AWS region where the cert is managed"
  default     = "us-east-1"
}

variable "org" {
  description = "The organization"
}

variable "org_unique" {
  description = "The organization, globally unique name for e.g. S3 buckets"
}

variable "app_name" {
  description = "The application name (hyphenated)"
}

variable "app_name_underscore" {
  description = "The application name"
}

variable "env" {
  description = "Environment, e.g. prod, stage, dev"
}

variable "owner" {
  description = "Creator of resources, e.g. ops or jake"
}

# https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html
variable "partition_name" {
  description = "aws is a common partition name. If your resources are in the China (Beijing) Region, aws-cn is the partition name."
  default     = "aws"
}

variable "aws_service_endpoint_ec2" {
  description = "EC2 endpoint. May vary depending on the region, e.g. AWS China"
  default     = "ec2.amazonaws.com"
}

variable "remote_state_s3_bucket_region" {
  description = "AWS region for state file, e.g. us-east-1"
}

variable "remote_state_s3_bucket_name" {
  description = "Bucket name for remote state, e.g. org-project-tfstate"
}

variable "remote_state_s3_key_prefix" {
  description = "Prefix in bucket where config starts, e.g. stage/ or project/stage/"
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = []
}

variable "public_domain" {
  description = "Public domain"
  default = "example.com"
}

variable "cdn_domain" {
  description = "CDN domain"
  default = "example.com"
}

variable "enable_kms" {
  description = "Enable encryption with KMS"
  default     = true
}

variable "enable_kms_public" {
  description = "Enable encryption with KMS on public S3 buckets, used with CloudFront"
  default     = false
}

variable "sse_algorithm" {
  description = "Encryption algorithm. aws:kms or AES256"
  default     = "aws:kms"
}

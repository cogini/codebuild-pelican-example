terraform {
  source = "${get_terragrunt_dir()}/../../../modules//s3-request-logs"
}
dependencies {
  paths = []
}
include {
  path = find_in_parent_folders()
}

inputs = {
  # Force S3 buckets to be deleted even when they are not empty
  force_destroy = true
}

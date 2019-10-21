terraform {
  source = "${get_terragrunt_dir()}/../../../modules//s3-public-web"
}
dependencies {
  paths = []
}
include {
  path = find_in_parent_folders()
}

inputs = {
  comp = "public-web"

  # Force S3 buckets to be deleted even when they are not empty
  force_destroy = true
}

terraform {
  source = "${get_terragrunt_dir()}/../../../modules//acm-public-cloudfront"
}
dependencies {
  paths = ["../route53-public"]
}
include {
  path = find_in_parent_folders()
}

inputs = {
  # create_route53_records = 1
}

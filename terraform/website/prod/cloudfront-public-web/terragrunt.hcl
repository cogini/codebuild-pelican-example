terraform {
  source = "${get_terragrunt_dir()}/../../../modules//cloudfront-public-web"
}
dependencies {
  paths = [
    "../s3-public-web",
    "../s3-request-logs",
    # "../acm-public-cloudfront",
    "../lambda-edge",
  ]
}
include {
  path = find_in_parent_folders()
}

inputs = {
  comp = "public-web"

  # enable_acm_certificate = true
  # viewer_protocol_policy = "redirect-to-https"
}

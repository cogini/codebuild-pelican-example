terraform {
  source = "${get_terragrunt_dir()}/../../../modules//lambda-edge"
}
dependencies {
  paths = ["../iam-lambda-edge"]
}
include {
  path = find_in_parent_folders()
}

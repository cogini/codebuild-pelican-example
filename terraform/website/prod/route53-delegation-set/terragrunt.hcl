terraform {
  source = "${get_terragrunt_dir()}/../../../modules//route53-delegation-set"
}
dependencies {
  paths = []
}
include {
  path = find_in_parent_folders()
}

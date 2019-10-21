terraform {
  source = "${get_terragrunt_dir()}/../../../modules//route53-public"
}
dependencies {
  paths = ["../route53-delegation-set"]
}
include {
  path = find_in_parent_folders()
}

inputs = {
  force_destroy = true
  # delegation_set_id = "N798FGBOZ5859"
}

# Create Route53 hosted zone for public domain.

data "terraform_remote_state" "ds" {
  backend = "s3"
  config = {
    bucket = var.remote_state_s3_bucket_name
    key    = "${var.remote_state_s3_key_prefix}/route53-delegation-set/terraform.tfstate"
    region = var.remote_state_s3_bucket_region
  }
}

resource "aws_route53_zone" "this" {
  name = var.public_domain

  # There is a bug where terraform parses the delegation_set_id reference as
  # a date, so we manually specify it instead of referencing it from the state.
  delegation_set_id = var.delegation_set_id != "" ? var.delegation_set_id : data.terraform_remote_state.ds.outputs.id

  force_destroy = var.force_destroy
}

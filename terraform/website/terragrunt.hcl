remote_state {
  backend = "s3"
  config = {
    bucket         = join("-", [get_env("ORG", ""), get_env("TF_VAR_app_name_hyphen", ""), get_env("ENV", "dev"), "tfstate"])
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = get_env("TF_VAR_remote_state_s3_bucket_region", "us-east-1")
    encrypt        = true
    dynamodb_table = join("-", [get_env("ORG", ""), get_env("TF_VAR_app_name_hyphen", ""), "tfstate"])
  }
}

terraform {
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
    required_var_files = [
      "${get_parent_terragrunt_dir()}/vars/common.tfvars",
      "${get_parent_terragrunt_dir()}/vars/${get_env("ENV", "dev")}.tfvars",
    ]
    optional_var_files = [
      # "${get_parent_terragrunt_dir()}/vars/${path_relative_to_include()}/include.tfvars",
      "${get_parent_terragrunt_dir()}/secrets/common.tfvars",
      "${get_parent_terragrunt_dir()}/secrets/${get_env("ENV", "dev")}.tfvars",
      # "${get_parent_terragrunt_dir()}/secrets/${path_relative_to_include()}/include.tfvars",
    ]
    arguments = []
  }
}

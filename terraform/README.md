# Terraform infrastructure provisioning

## Prerequisites

Install ASDF as described here:
https://www.cogini.com/blog/using-asdf-with-elixir-and-phoenix/

Install the terraform and terragrunt plugins:

```shell
asdf plugin-add terraform
asdf plugin-add terragrunt
asdf plugin-add packer

asdf install
```

Or install from homebrew:

```shell
brew install terraform
brew install terragrunt
brew install packer
```

Create an AWS account.
Create an IAM user with SuperUser permissions or something more restricted.
Generate IAM access keys for the user and put them in `~/.aws/credentials`:

```text
[myorg-dev]
aws_access_key_id = XXX
aws_secret_access_key = YYY
```

Before running any commands, set the environment var `ENV` to match the runtime
environment (dev, stage, prod) and load `set_env.sh`.

```bash
cd terraform/app_name
cp set_env.sh.sample set_env.sh

export ENV=dev
source set_env.sh
```

## Launch infrastructure

To launch all the required infrastructure for a given env:

```bash
terragrunt apply-all --terragrunt-working-dir "$ENV"
```

This runs Terraform for everything below the `dev` directory. The remote state
is stored in S3 for the given environment and locked with DynamoDB (managed by
terragrunt). If the infrastructure is already in the required state,
`apply-all` will do nothing (idempotent).

For specific actions see **General Terraform/terragrunt commands** section.

## General Terraform/terragrunt commands

### Plan all for an environment

```bash
terragrunt plan-all --terragrunt-working-dir "$ENV"
```

### Plan a single infrastructure part

```bash
terragrunt plan --terragrunt-working-dir "$ENV/vpc"
```

### Apply all for an environment

```bash
terragrunt apply-all --terragrunt-working-dir "$ENV"
```

### Apply a single infrastructure part

```bash
terragrunt apply --terragrunt-working-dir "$ENV/vpc"
```

### Destroy all infrastructure

```bash
terragrunt destroy-all --terragrunt-working-dir "$ENV"
```

### Destroy a single infrastructure part

```bash
terragrunt destroy --terragrunt-working-dir "$ENV/vpc"
```

## Hard reset

To clear the state completely and start again if the Terraform state is too
messed up to even do destroy-all:

* Delete the resource group in Azure
* Delete the S3 state bucket and the DynamoDB locking table
* Run `rm -rf "$TMPDIR/terragrunt"`

When naming resources:

* Prefer lower case + underscore if possible for the resource
* If underscores are not allowed, use hyphens instead of underscores
* If neither underscores or hyphens are allowed, use all lower case

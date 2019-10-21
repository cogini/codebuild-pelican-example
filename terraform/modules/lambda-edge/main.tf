# Set up lambda edge functions for CloudFront

# https://qiita.com/maruware/items/557ff3c11a45d5414cea

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = var.remote_state_s3_bucket_name
    key    = "${var.remote_state_s3_key_prefix}/iam-lambda-edge/terraform.tfstate"
    region = var.remote_state_s3_bucket_region
  }
}

data "archive_file" "index_html" {
  type        = "zip"
  source_dir  = "lambda/index_html"
  output_path = "lambda/dst/index_html.zip"
}

resource "aws_lambda_function" "index_html" {
  provider = aws.cloudfront

  filename         = data.archive_file.index_html.output_path
  function_name    = "${var.app_name}-index_html"
  role             = data.terraform_remote_state.iam.outputs.lambda_edge_service_role_arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.index_html.output_base64sha256
  runtime          = "nodejs8.10"

  publish = true

  memory_size = 128
  timeout     = 3
}

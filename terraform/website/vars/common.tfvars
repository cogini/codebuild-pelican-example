# Common / default settings for all environments

# Globally unique organization name, used to name things like S3 buckets
org_unique = "cogini"

# Name of the app
app_name = "website"

# Region to build in
# aws ec2 describe-regions
aws_region = "us-west-1"

# Availiability zones
# aws ec2 describe-availability-zones --region ap-northeast-1
azs = ["us-west-1a", "us-west-1b"]

# Whether to use KMS (not supported in China)
# enable_kms = "true"

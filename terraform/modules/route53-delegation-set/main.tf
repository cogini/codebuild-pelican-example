# Create Route53 delgation set
#
# This is a set of nameservers, separate from the Route53 hosted zone,
# allowing the zone to be deleted and created again without needing to change
# the nameserver list in the domain registrar.

# https://www.terraform.io/docs/providers/aws/r/route53_delegation_set.html
resource "aws_route53_delegation_set" "main" {
  reference_name = "main"
}

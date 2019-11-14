provider "aws" {
  region = "us-east-1"
  alias  = "acm_provider"
}

data "aws_route53_zone" "selected" {
  name = "${var.parent_zone_name}"
}

module "aws-cert" {
  source = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

  domain_name  = "${var.domain}"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"

  subject_alternative_names = "${var.alternative_names}"
  
  tags = "${var.acm_tags}"
}

data "aws_acm_certificate" "this" {
  domain     = "${var.domain}"
  statuses   = ["ISSUED", "PENDING_VALIDATION"]
  provider = "aws.acm_provider"
  
  depends_on = [module.aws-cert]
}

module "cdn" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn.git?ref=0.11.0"
  namespace                    = "${var.namespace}"
  stage                        = "${var.stage}"
  name                         = "${var.name}"
  aliases                      = "${concat(list(var.domain), var.alternative_names)}"
  parent_zone_name             = "${var.parent_zone_name}"
  acm_certificate_arn          = "${data.aws_acm_certificate.this.arn}"
  default_root_object          = "${var.default_root_object}"
  default_ttl                  = "${var.default_ttl}"
  enabled                      = "${var.enabled}"
  lambda_function_association  = "${var.lambda_function_association}"
  log_expiration_days          = "${var.log_expiration_days}"
  log_glacier_transition_days  = "${var.log_glacier_transition_days}"
  log_include_cookies          = "${var.log_include_cookies}"
  log_prefix                   = "${var.log_prefix}"
  log_standard_transition_days = "${var.log_standard_transition_days}"
  max_ttl                      = "${var.max_ttl}"
  min_ttl                      = "${var.min_ttl}"
  price_class                  = "${var.price_class}"
  tags                         = "${var.tags}"
  use_regional_s3_endpoint     = "${var.use_regional_s3_endpoint}"
  web_acl_id                   = "${var.web_acl_id}"
  origin_force_destroy         = "true"

}

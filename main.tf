provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}

data "aws_route53_zone" "selected" {
  name = "${var.hosted_zone_name}"
}

module "aws-cert" {
  source = "github.com/lean-delivery/tf-module-aws-acm"

  providers = {
    aws = "aws.acm_provider"
  }

  domain  = "${var.domain}"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"

  alternative_domains_count = "${var.alternative_domains_count}"
  alternative_domains       = "${var.alternative_domains}"

  tags = "${var.acm_tags}"
}

resource "null_resource" "dummy" {
  # untill https://github.com/terraform-providers/terraform-provider-aws/issues/8945 will be resolved
  provisioner "local-exec" {
    command = "sleep 100 && echo ${module.aws-cert.certificate_arn}"
  }
}

data "aws_acm_certificate" "this" {
  depends_on = ["null_resource.dummy"]
  domain     = "${module.aws-cert.certificate_domain}"
  statuses   = ["ISSUED", "PENDING_VALIDATION"]
}

module "cdn" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn.git?ref=master"
  namespace                    = "${var.namespace}"
  stage                        = "${var.stage}"
  name                         = "${var.name}"
  aliases                      = "${concat(list(var.domain), var.alternative_domains)}"
  parent_zone_name             = "${var.hosted_zone_name}"
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
  origin_bucket                = "${var.origin_bucket}"
  price_class                  = "${var.price_class}"
  tags                         = "${var.tags}"
  use_regional_s3_endpoint     = "${var.use_regional_s3_endpoint}"
  web_acl_id                   = "${var.web_acl_id}"
  origin_force_destroy         = "true"

  providers = {
    aws = "aws.acm_provider"
  }
}

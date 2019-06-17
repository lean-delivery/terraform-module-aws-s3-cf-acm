provider "aws" {
  alias      = "acm_provider"
  region     = "us-east-1"
}

module "aws-cert" {
  source   = "github.com/lean-delivery/tf-module-aws-acm"
  providers = {
    aws = "aws.acm_provider"
  }
  domain   = "${var.domain}"
  zone_id  = "${var.zone_id}"

  alternative_domains_count = 1
  alternative_domains = "${var.alternative_domains}"
  tags {
    Name = "${var.tag}"
  }
}

resource "null_resource" "dummy" {
  provisioner "local-exec" {
    command = "sleep 100 && echo ${module.aws-cert.certificate_arn}"
  }
}

data "aws_acm_certificate" "this" {
  depends_on = ["null_resource.dummy"]
  domain     = "${var.domain}"
}

module "cdn" {
  source               = "git::https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn.git?ref=master"
  namespace            = "${var.namespace}"
  stage                = "${var.stage}"
  name                 = "${var.name}"
  aliases              = "${var.aliases}"
  parent_zone_name     = "${var.parent_zone_name}"
  acm_certificate_arn  = "${data.aws_acm_certificate.this.arn}"
  origin_force_destroy = "true"
}
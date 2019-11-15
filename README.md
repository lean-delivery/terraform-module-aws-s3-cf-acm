# tf-module-aws-s3-cf-acm
Terraform module for static site with SSL
required_version = ">= 0.12"

## Usage
```hcl
module "s3-cf-acm" {
  source = "git@github.com:lean-delivery/tf-module-aws-s3-cf-acm.git"

  namespace        = "test"
  stage            = "test"
  name             = "cf-bucket"
  parent_zone_name = "example.com"
  acm_tags = {
    Name = "Example"
  }
  domain                   = "static.example.com"
  use_regional_s3_endpoint = "true"
  origin_bucket            = "S3-static-files-content"
  origin_force_destroy     = "yes"
  default_root_object      = "index.html"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acm\_certificate\_arn | Existing ACM Certificate ARN | string | `""` | no |
| acm\_tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |
| aliases | List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront | list | `<list>` | no |
| alternative\_names | Domian name alternatives for ACM certificate | list | `<list>` | no |
| bucket\_domain\_format | Format of bucket domain name | string | `"%s.s3.amazonaws.com"` | no |
| default\_root\_object | Object that CloudFront return when requests the root URL | string | `"index.html"` | no |
| default\_ttl | Default amount of time (in seconds) that an object is in a CloudFront cache | string | `"60"` | no |
| domain | A domain name for which certificate will be created | string | n/a | yes |
| enabled | Select Enabled if you want CloudFront to begin processing requests as soon as the distribution is created, or select Disabled if you do not want CloudFront to begin processing requests after the distribution is created. | string | `"true"` | no |
| lambda\_function\_association | A config block that triggers a lambda function with specific actions | list | `<list>` | no |
| log\_expiration\_days | Number of days after which to expunge the objects | string | `"90"` | no |
| log\_glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | string | `"60"` | no |
| log\_include\_cookies | Include cookies in access logs | string | `"false"` | no |
| log\_prefix | Path of logs in S3 bucket | string | `""` | no |
| log\_standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the glacier tier | string | `"30"` | no |
| max\_ttl | Maximum amount of time (in seconds) that an object is in a CloudFront cache | string | `"31536000"` | no |
| min\_ttl | Minimum amount of time that you want objects to stay in CloudFront caches | string | `"0"` | no |
| name | Name of static content (forming bucket name) | string | n/a | yes |
| namespace | Namespace (forming bucket name) | string | n/a | yes |
| origin\_bucket | Name of S3 bucket | string | `""` | no |
| origin\_force\_destroy | Delete all objects from the bucket  so that the bucket can be destroyed without error (e.g. `true` or `false`) | string | `"false"` | no |
| parent\_zone\_id | ID of the hosted zone to contain this record  (or specify `parent_zone_name`) | string | `""` | no |
| parent\_zone\_name | Name of the hosted zone to contain this record (or specify parent_zone_id) | string | n/a | yes |
| price\_class | Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | string | `"PriceClass_100"` | no |
| stage | Stage of environment (e.g. `dev` or `prod`) (forming bucket name) | string | `"dev"` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |
| use\_regional\_s3\_endpoint | When set to 'true' the s3 origin_bucket will use the regional endpoint address instead of the global endpoint address | string | `"false"` | no |
| web\_acl\_id | ID of the AWS WAF web ACL that is associated with the distribution | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cf\_arn | ARN of AWS CloudFront distribution |
| cf\_domain\_name | Domain name corresponding to the distribution |
| cf\_etag | Current version of the distribution's information |
| cf\_hosted\_zone\_id | CloudFront Route 53 zone ID |
| cf\_id | ID of AWS CloudFront distribution |
| cf\_status | Current status of the distribution |
| s3\_bucket | Name of S3 bucket |
| s3\_bucket\_domain\_name | Domain of S3 bucket |

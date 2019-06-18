variable "namespace" {
  description = "Namespace (forming bucket name)"
  type        = "string"
}

variable "stage" {
  description = "Stage of environment (e.g. `dev` or `prod`) (forming bucket name)"
  type        = "string"
  default     = "dev"
}

variable "name" {
  description = "Name of static content (forming bucket name)"
  type        = "string"
}

variable "hosted_zone_name" {
  description = "Name of the hosted zone to contain this record (or specify parent_zone_id)"
  type        = "string"
}

variable "alternative_domains_count" {
  description = "Count of Domian name alternatives for ACM certificate"
  type        = "string"
  default     = "0"
}

variable "domain" {
  description = "A domain name for which certificate will be created"
  type        = "string"
}

variable "alternative_domains" {
  description = "Domian name alternatives for ACM certificate"
  type        = "list"
  default     = []
}

variable "acm_tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "enabled" {
  default     = "true"
  type        = "string"
  description = "Select Enabled if you want CloudFront to begin processing requests as soon as the distribution is created, or select Disabled if you do not want CloudFront to begin processing requests after the distribution is created."
}

variable "acm_certificate_arn" {
  description = "Existing ACM Certificate ARN"
  type        = "string"
  default     = ""
}

variable "use_regional_s3_endpoint" {
  type        = "string"
  description = "When set to 'true' the s3 origin_bucket will use the regional endpoint address instead of the global endpoint address"
  default     = "false"
}

variable "origin_bucket" {
  default     = ""
  type        = "string"
  description = "Name of S3 bucket"
}

variable "origin_force_destroy" {
  default     = "false"
  description = "Delete all objects from the bucket  so that the bucket can be destroyed without error (e.g. `true` or `false`)"
}

variable "bucket_domain_format" {
  default     = "%s.s3.amazonaws.com"
  description = "Format of bucket domain name"
}

variable "default_root_object" {
  default     = "index.html"
  description = "Object that CloudFront return when requests the root URL"
}

variable "log_include_cookies" {
  default     = "false"
  description = "Include cookies in access logs"
}

variable "log_prefix" {
  default     = ""
  description = "Path of logs in S3 bucket"
}

variable "log_standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the glacier tier"
  default     = "30"
}

variable "log_glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = "60"
}

variable "log_expiration_days" {
  description = "Number of days after which to expunge the objects"
  default     = "90"
}

variable "price_class" {
  default     = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "default_ttl" {
  default     = "60"
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  default     = "0"
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  default     = "31536000"
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "parent_zone_id" {
  default     = ""
  description = "ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}

variable "lambda_function_association" {
  type        = "list"
  default     = []
  description = "A config block that triggers a lambda function with specific actions"
}

variable "web_acl_id" {
  type        = "string"
  default     = ""
  description = "ID of the AWS WAF web ACL that is associated with the distribution"
}

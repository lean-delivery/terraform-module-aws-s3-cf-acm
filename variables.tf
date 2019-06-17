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

variable "aliases" {
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  type        = "list"
}

variable "parent_zone_name" {
  description = "Name of the hosted zone to contain this record (or specify parent_zone_id)"
  type        = "string"
}
variable "zone_id" {
  description = "Zone Id of a hosted zone for which the certificate will be created"
  type        = "string"
}

variable "domain" {
  description = "A domain name for which certificate will be created"
  type        = "string"
}

variable "alternative_domains" {
  description = "Domian name alternatives for ACM certificate"
  type        = "list"
}

variable "tag" {
  description = "Tag for ACM sertificate"
  type        = "string"
}

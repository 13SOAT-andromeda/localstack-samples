provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source      = "../modules/s3_bucket"
  bucket_name = "${var.bucket_prefix}-aws-bucket"
}

module "api_gateway" {
  source   = "../modules/api_gateway"
  api_name = "${var.bucket_prefix}-aws-api"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_prefix" {
  type    = string
  default = "my-sample-project"
}

output "bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

output "api_base_url" {
  value = module.api_gateway.base_url
}

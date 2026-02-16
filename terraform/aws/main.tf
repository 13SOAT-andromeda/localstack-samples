provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source      = "../modules/s3_bucket"
  bucket_name = "${var.bucket_prefix}-aws-bucket"
}

module "api_gateway" {
  source     = "../modules/api_gateway"
  api_name   = "${var.bucket_prefix}-aws-api"
  lambda_arn = module.hello_lambda.lambda_arn
  stage_name = "dev"
}

module "hello_lambda" {
  source          = "../modules/lambda"
  function_name   = "hello-go-lambda"
  lambda_zip_path = var.lambda_zip_path
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_prefix" {
  type    = string
  default = "my-sample-project"
}

variable "lambda_zip_path" {
  type        = string
  description = "Path to the Go binary zip"
}

output "bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

output "api_base_url" {
  value = module.api_gateway.base_url
}

output "lambda_arn" {
  value = module.hello_lambda.lambda_arn
}

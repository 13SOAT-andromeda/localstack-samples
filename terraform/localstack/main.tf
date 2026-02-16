provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    apigateway     = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    secretsmanager = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

module "s3_bucket" {
  source      = "../modules/s3_bucket"
  bucket_name = "${var.bucket_prefix}-localstack-bucket"
}

module "api_gateway" {
  source     = "../modules/api_gateway"
  api_name   = "${var.bucket_prefix}-localstack-api"
  lambda_arn = module.hello_lambda.lambda_arn
  stage_name = "dev"
}

module "hello_lambda" {
  source          = "../modules/lambda"
  function_name   = "hello-go-lambda"
  lambda_zip_path = var.lambda_zip_path
}

variable "bucket_prefix" {
  type    = string
  default = "my-sample-project"
}

variable "lambda_zip_path" {
  type        = string
  description = "Path to the Go binary zip"
  default     = "./dummy_lambda.zip" # Placeholder for initialization
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

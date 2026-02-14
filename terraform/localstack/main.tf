provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}

module "s3_bucket" {
  source      = "../modules/s3_bucket"
  bucket_name = "${var.bucket_prefix}-localstack-bucket"
}

variable "bucket_prefix" {
  type    = string
  default = "my-sample-project"
}

output "bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

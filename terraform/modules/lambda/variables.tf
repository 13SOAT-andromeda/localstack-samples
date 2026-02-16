variable "function_name" {
  type        = string
  description = "Name of the lambda function"
}

variable "lambda_zip_path" {
  type        = string
  description = "Local path to the Lambda zip file (e.g., ../../serverless-samples/main.zip)"
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

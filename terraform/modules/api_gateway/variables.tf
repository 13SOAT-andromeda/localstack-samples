variable "api_name" {
  type        = string
  description = "The name of the API Gateway"
}

variable "lambda_arn" {
  type        = string
  description = "The ARN of the Lambda function to integrate with"
}

variable "stage_name" {
  type        = string
  default     = "dev"
  description = "The deployment stage name"
}

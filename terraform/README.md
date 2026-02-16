# Terraform Infrastructure

This directory contains Terraform configurations for deploying a serverless application consisting of an S3 bucket, a Lambda function, and an API Gateway.

## Structure

- `aws/`: Root module for deploying to real AWS.
- `localstack/`: Root module for deploying to LocalStack (local environment).
- `modules/`: Shared modules for S3, Lambda, and API Gateway.

## Prerequisite: Lambda Zip

Both layers require a Lambda deployment package. For LocalStack, a `dummy_lambda.zip` is provided. For AWS, you should provide the path to your actual Lambda zip file.

## Usage

### LocalStack (Local)

1. Start LocalStack:
   ```bash
   localstack start -d
   ```

2. Deploy:
   ```bash
   cd localstack
   terraform init
   terraform apply
   ```

### AWS (Remote)

1. Configure your AWS credentials (e.g., `aws configure` or environment variables).

2. Deploy:
   ```bash
   cd aws
   terraform init
   terraform apply -var="lambda_zip_path=/path/to/your/lambda.zip"
   ```

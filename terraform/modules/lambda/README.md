# Lambda Module

This module deploys a Golang Lambda function using the `provided.al2023` runtime.

## How to use with `serverless-samples` (Golang)

### 1. Build your Go code
In your `serverless-samples` repository:

```bash
# Compile for Linux/AMD64
GOOS=linux GOARCH=amd64 go build -o bootstrap main.go

# Zip the binary (must be named bootstrap)
zip function.zip bootstrap
```

**Note:** It is crucial that the Go binary is named exactly `bootstrap` and is at the root of the zip file for the `provided.al2023` runtime to work correctly.

### 2. Run Terraform
Point Terraform to the resulting zip file using the `lambda_zip_path` variable.

**For LocalStack:**
```bash
cd terraform/localstack
terraform apply -var="lambda_zip_path=../../../serverless-samples/go-gin-lambda/function.zip"
```

**For AWS:**
```bash
cd terraform/aws
terraform apply -var="lambda_zip_path=../../../serverless-samples/go-gin-lambda/function.zip"
```

## Structure
- `main.tf`: Creates the IAM Role and the Lambda function.
- `variables.tf`: Configuration for function name and zip path.

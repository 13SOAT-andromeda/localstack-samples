# Terraform Infrastructure

This directory contains two Terraform layers for deploying a simple S3 bucket.

## Layers

- **aws**: Deploys directly to AWS.
- **localstack**: Deploys to a LocalStack instance running on `localhost:4566`.

## Usage

### AWS Layer

```bash
cd aws
terraform init
terraform plan
terraform apply
```

### LocalStack Layer

Ensure LocalStack is running:

```bash
localstack start -d
```

Then:

```bash
cd localstack
terraform init
terraform plan
terraform apply
```

## Shared Modules

The `modules/s3_bucket` directory contains a shared module used by both layers to ensure consistency.

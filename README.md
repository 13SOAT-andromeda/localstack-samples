# LocalStack Usage Guide

## Quick Links
- [Terraform Infrastructure Overview](terraform/README.md)
- [API Gateway Module Details & Usage](terraform/modules/api_gateway/README.md)

This `README.md` provides a simple and clean guide on how to use LocalStack for local AWS cloud development.

## What is LocalStack?

LocalStack provides a fully functional local cloud stack. It allows you to develop and test your cloud applications entirely on your local machine without connecting to a remote AWS cloud provider. This speeds up development, reduces costs, and allows for offline work.

## Installation

LocalStack can be installed via `pip` (Python package installer) or Docker.

### Using pip

First, ensure you have Python and `pip` installed.

```bash
pip install localstack
```

### Using Docker

Ensure you have Docker installed and running on your system. You can pull the LocalStack image:

```bash
docker pull localstack/localstack
```

## How to Use LocalStack

### 1. Start LocalStack

#### With pip

To start LocalStack using the `localstack` CLI:

```bash
localstack start
```

This will download necessary images (if using Docker internally) and start all default AWS services (S3, Lambda, DynamoDB, etc.).

#### With Docker

If you prefer to run LocalStack directly via Docker, you can use:

```bash
docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack
```

This command maps the necessary ports for LocalStack services to your local machine.

### 2. Verify LocalStack is Running

Once started, you should see output indicating that services are running. You can also check the health endpoint:

```bash
curl http://localhost:4566/health
```

### 3. Interact with LocalStack (using AWS CLI)

To interact with LocalStack, you need to configure your AWS CLI to point to your local endpoint.

**Important:** Make sure you have the AWS CLI installed.

Set up an alias for easier use (optional but recommended):

```bash
alias awslocal="aws --endpoint-url=http://localhost:4566"
```

Now you can use `awslocal` exactly like `aws`.

#### Example: Create an S3 Bucket

```bash
awslocal s3 mb s3://my-test-bucket
```

#### Example: List S3 Buckets

```bash
awslocal s3 ls
```

You should see `my-test-bucket` in the output.

### 4. Stop LocalStack

#### With pip

If you started LocalStack with `localstack start`, you can stop it with:

```bash
localstack stop
```

#### With Docker

If you started LocalStack with `docker run` in the foreground, you can stop it by pressing `Ctrl+C` in the terminal where it's running. If you ran it in detached mode (`-d`), you'll need to find its container ID and stop it:

```bash
docker ps # Find the container ID for localstack/localstack
docker stop <container-id>
```

## More Information

For more detailed information, examples, and advanced configurations, please refer to the [LocalStack Documentation](https://docs.localstack.cloud/).

## Terraform Configuration

This repository includes Terraform configurations to deploy resources to both AWS and LocalStack.

- **S3 Bucket**: A simple module to create S3 buckets.
- **API Gateway**: A module for a mock REST API.

To get started with Terraform:
```bash
cd terraform
# Follow instructions in terraform/README.md
```

# API Gateway Module

This module sets up a simple AWS API Gateway with a `/hello` endpoint that returns a mock JSON response.

## Usage

The module creates a REST API with a `GET` method at the `/hello` path.

### Accessing the API (AWS)

In a standard AWS environment, the API is accessible via the URL provided in the `api_base_url` output:

```bash
curl https://<api-id>.execute-api.<region>.amazonaws.com/prod/hello
```

### Accessing the API (LocalStack)

When running locally with LocalStack, the root URL (`http://localhost:4566`) is shared by all services. To target the API Gateway specifically, you must include the **API ID** in the path.

1. **Get the API ID**:
   ```bash
   cd terraform/localstack
   terraform output api_id
   ```

2. **Invoke the Endpoint**:
   Use the following URL format (replacing `<api_id>` with the output from the previous step):

   ```bash
   curl http://localhost:4566/restapis/<api_id>/prod/_user_request_/hello
   ```

   *Note: If you simply call `http://localhost:4566/hello`, LocalStack may mistake the request for an S3 bucket named "hello".*

## Response
Success returns:
```json
{
  "message": "Hello from API Gateway!"
}
```

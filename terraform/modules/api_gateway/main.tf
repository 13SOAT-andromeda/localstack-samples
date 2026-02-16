resource "aws_api_gateway_rest_api" "simple_api" {
  name        = var.api_name
  description = "A simple API Gateway for demonstration"
}

resource "aws_api_gateway_resource" "hello" {
  rest_api_id = aws_api_gateway_rest_api.simple_api.id
  parent_id   = aws_api_gateway_rest_api.simple_api.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "hello_get" {
  rest_api_id   = aws_api_gateway_rest_api.simple_api.id
  resource_id   = aws_api_gateway_resource.hello.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "mock" {
  rest_api_id = aws_api_gateway_rest_api.simple_api.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.hello_get.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_method_response" "hello_200" {
  rest_api_id = aws_api_gateway_rest_api.simple_api.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.hello_get.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "hello_response" {
  rest_api_id = aws_api_gateway_rest_api.simple_api.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.hello_get.http_method
  status_code = aws_api_gateway_method_response.hello_200.status_code

  response_templates = {
    "application/json" = jsonencode({
      message = "Hello from API Gateway!"
    })
  }

  depends_on = [aws_api_gateway_integration.mock]
}

resource "aws_api_gateway_deployment" "simple" {
  rest_api_id = aws_api_gateway_rest_api.simple_api.id

  depends_on = [
    aws_api_gateway_integration.mock,
    aws_api_gateway_integration_response.hello_response
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.simple.id
  rest_api_id   = aws_api_gateway_rest_api.simple_api.id
  stage_name    = "prod"
}

output "base_url" {
  value = aws_api_gateway_stage.dev.invoke_url
}

output "api_id" {
  value = aws_api_gateway_rest_api.simple_api.id
}

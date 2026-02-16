output "base_url" {
  value = "${aws_api_gateway_deployment.simple.invoke_url}${aws_api_gateway_stage.prod.stage_name}"
}

output "api_id" {
  value = aws_api_gateway_rest_api.simple_api.id
}

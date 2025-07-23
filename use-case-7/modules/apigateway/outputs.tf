output "api_endpoint" {
  description = "URL endpoint for the API Gateway"
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}


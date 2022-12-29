output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpce_id" {
  value = aws_vpc_endpoint.amazon_api_gateway_vpce.id
}
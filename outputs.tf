output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpce_id" {
  value = module.vpc.vpce_id
}

output "api_url" {
  value = module.api-gateway.api_url
}
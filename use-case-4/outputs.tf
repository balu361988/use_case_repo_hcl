output "web_public_ips" {
  description = "Public IP addresses of web servers"
  value       = module.ec2.web_public_ips
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}


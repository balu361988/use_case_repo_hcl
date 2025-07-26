output "alb_arn" {
  value = aws_lb.app_alb.arn
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "tg_frontend_arn" {
  value = aws_lb_target_group.frontend.arn
}

output "tg_backend_arn" {
  value = aws_lb_target_group.backend.arn
}

output "tg_auth_arn" {
  value = aws_lb_target_group.auth.arn
}


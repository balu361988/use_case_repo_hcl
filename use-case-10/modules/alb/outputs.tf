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
  value = aws_lb_target_group.auth_tg.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.http.arn
}


output "auth_listener_rule_depends_on" {
  value = aws_lb_listener_rule.auth_rule
}


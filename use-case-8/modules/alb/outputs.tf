output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "patient_target_group_arn" {
  value = aws_lb_target_group.patient_service.arn
}

output "appointment_target_group_arn" {
  value = aws_lb_target_group.appointment_service.arn
}

output "patient_listener_rule_depends_on" {
  value = aws_lb_listener_rule.patient_service.id
}

output "appointment_listener_rule_depends_on" {
  value = aws_lb_listener_rule.appointment_service.id
}

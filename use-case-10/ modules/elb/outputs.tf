output "alb_dns" {
  value = aws_lb.main.dns_name
}

output "patient_target_group_arn" {
  value = aws_lb_target_group.patient.arn
}

output "appointment_target_group_arn" {
  value = aws_lb_target_group.appointment.arn
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}

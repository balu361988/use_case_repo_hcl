resource "aws_lb_target_group" "auth_tg" {
  name        = "${var.environment}-tg-auth-alt"
  port        = 3002
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/health"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "auth_rule" {
  listener_arn = aws_lb_listener.http.arn  # ✅ Internal reference to the listener
  priority     = 30

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.auth_tg.arn
  }

  condition {
    path_pattern {
      values = ["/auth*", "/auth/health"]
    }
  }
}

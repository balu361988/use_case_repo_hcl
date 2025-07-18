package main

deny[msg] {
  input.resource_type == "aws_security_group"
  rule := input.config.ingress[_]
  rule.cidr_blocks[_] == "0.0.0.0/0"
  msg = sprintf("Security Group %v allows ingress from 0.0.0.0/0", [input.name])
}

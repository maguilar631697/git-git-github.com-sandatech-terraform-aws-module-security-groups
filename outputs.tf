#Rules map
output "association-map-protocols" {
  value = local.sg_rule_protocol
}

output "egress-association-map-protocols" {
  value = local.egress_sg_rule_protocol
}

#ARN for new sg
output "sg-arn" {
  value = aws_security_group.sg.arn
}

output "sg-id" {
  value = aws_security_group.sg.id
}
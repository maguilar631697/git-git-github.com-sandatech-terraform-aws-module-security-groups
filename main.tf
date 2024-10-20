locals {
  sg_rules = flatten([
    for ingress_rule in var.security_group_ingress : [
      for i in range(0, length(ingress_rule.from_port)): {
        description     = lookup(ingress_rule, "description", "")
        cidr_blocks     = lookup(ingress_rule, "cidr_blocks", [])
        security_groups = lookup(ingress_rule, "security_groups", [])
        self            = lookup(ingress_rule, "self", null)
        protocols       = ingress_rule.protocols
        from_port       = ingress_rule.from_port[i]
        to_port         = ingress_rule.to_port[i]
      }
    ]
  ])
  sg_rule_protocol = flatten([
    for ingress_rule in local.sg_rules : [
      for protocol in ingress_rule.protocols: {
        description     = ingress_rule.description
        cidr_blocks     = ingress_rule.cidr_blocks
        security_groups = ingress_rule.security_groups
        self            = ingress_rule.self
        protocol        = protocol
        from_port       = ingress_rule.from_port
        to_port         = ingress_rule.to_port
      }
    ]
  ])
  egress_sg_rules = flatten([
    for egress_rule in var.security_group_egress : [
      for i in range(0, length(egress_rule.from_port)): {
        description     = lookup(egress_rule, "description", "")
        cidr_blocks     = lookup(egress_rule, "cidr_blocks", [])
        security_groups = lookup(egress_rule, "security_groups", [])
        self            = lookup(egress_rule, "self", null)
        protocols       = lookup(egress_rule, "protocols", "")
        from_port       = lookup(egress_rule, "from_port", "")[i]
        to_port         = lookup(egress_rule, "to_port", "")[i]
      }
    ]
  ])
  egress_sg_rule_protocol = flatten([
    for egress_rule in local.egress_sg_rules : [
      for protocol in egress_rule.protocols: {
        description     = egress_rule.description
        cidr_blocks     = egress_rule.cidr_blocks
        security_groups = egress_rule.security_groups
        self            = egress_rule.self
        protocol        = protocol
        from_port       = egress_rule.from_port
        to_port         = egress_rule.to_port
      }
    ]
  ])
}


resource "aws_security_group" "sg" {
 name        = "sd-${var.region}-sg-${var.sg_name}"
 description = "sd-${var.region}-sg-${var.sg_name}"
 vpc_id      = var.vpc_id

  dynamic "egress" {
   for_each = [for key in local.egress_sg_rule_protocol :{
      cidr_blocks     = key.cidr_blocks
      security_groups = key.security_groups
      self            = key.self
      description     = key.description
      from_port       = key.from_port
      to_port         = key.to_port
      protocol        = key.protocol
    }]
    
   content {
     description     = egress.value.description
     from_port       = egress.value.from_port
     to_port         = egress.value.to_port
     protocol        = egress.value.protocol
     cidr_blocks     = egress.value.cidr_blocks
     security_groups = egress.value.security_groups
     self            = egress.value.self
    }
  }

 dynamic "ingress" {
   for_each = [for key in local.sg_rule_protocol :{
      cidr_blocks     = key.cidr_blocks
      security_groups = key.security_groups
      self            = key.self
      description     = key.description
      from_port       = key.from_port
      to_port         = key.to_port
      protocol        = key.protocol
    }]
    
   content {
     description     = ingress.value.description
     from_port       = ingress.value.from_port
     to_port         = ingress.value.to_port
     protocol        = ingress.value.protocol
     cidr_blocks     = ingress.value.cidr_blocks
     security_groups = ingress.value.security_groups
     self            = ingress.value.self
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "sd-${var.region}-sg-${var.sg_name}"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}
#SG NAme
variable "sg_name" {
  description = "Short Name for your securitygroup"
  default = ""
}

#SG Ingress rules
variable "security_group_ingress" {
  description = "List of maps of ingress rules to set on the security group"
  default   = []
}

#SG Egress rules
variable "security_group_egress" {
  description = "List of maps of egress rules to set on the security group"
  default   = []
}

#Tags
variable  "tags" {
    description = "Tags map" 
    default = {}
}

#VPC ID
variable  "vpc_id" {
    description = "VPC ID" 
    default = ""
}

variable "region" {
  description = "region"
  default = ""
}
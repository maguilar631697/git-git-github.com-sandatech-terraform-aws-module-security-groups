
module "sg01" {
    source = "../../"
    #version = ""

    vpc_id                  = data.terraform_remote_state.vpc-rd-us-east-1.outputs.vpc_id //var.vpc_id
    sg_name                 = var.sg_name
    security_group_ingress  = var.security_group_ingress
    security_group_egress   = var.security_group_egress
    region                  = var.region

    tags = var.tags
}
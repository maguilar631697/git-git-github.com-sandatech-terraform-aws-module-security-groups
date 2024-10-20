# terraform-aws-module-security-groups-01

Terraform module to configure security groups. At this time this module supports creating security groups from a map containing all required properties, minus security group source ids. 

## Terraform versions

Terraform 0.12. Pin module version to `~> v1.0`. Submit pull-requests to `master` branch.

## Usage

```hcl
module "sg01" {
    source = "../../"
    #version = ""

    vpc_id                  = data.terraform_remote_state.vpc-rd-us-east-1.outputs.vpc_id //var.vpc_id
    sg_name                 = var.sg_name
    security_group_ingress  = var.security_group_ingress
    region                  = var.region

    tags = var.tags
}
```


## Sample map variable

```hcl
security_group_ingress = [
    {
      description              = "IPs from PA"
      cidr_blocks              = ["192.168.1.10/32", "192.168.1.3/32"]
      from_port                = ["443"]
      to_port                  = ["443"]
      protocols                 = ["tcp", "udp"]
    },
    {
      description              = "SandataIPs"
      cidr_blocks              = ["192.168.1.14/32", "192.168.1.6/32"]
      from_port                = ["22", "3389", "443", "10000"]
      to_port                  = ["22", "3389", "443", "20000"]
      protocols                 = ["tcp", "udp"]
    }
  ]
```

## Assumptions

Module is to be used with Terraform > 0.12.


## Examples

* [SG Complete Example](https://github.com/sandatech/terraform-aws-module-security-groups-01/tree/master/examples/complete)

## Authors

Module managed by [Danny Aguilar](https://github.com/sandatech) [LinkedIn](https://www.linkedin.com/in/milton-danny-aguilar-992a3549/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.34 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | this region variable is to be used to set the name | `string` | n/a | no |
| security\_group\_ingress | List of maps of ingress rules to set on the security group. | `list` | n/a | yes |
| security\_group\_egress | List of maps of egress rules to set on the security group. | `list` | n/a | no |
| tags | (Optional) Tags map | `map` | n/a | no |
| vpc_id | Required VPC id | `string` | n/a | yes |
| sg_name | Short Name for your securitygroup | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| association-map-protocols | Map of sg rules created |
| egress-association-map-protocols | Map of sg egress rules created |
| sg-arn | Security group ARN |
| sg-arn | Security group ID  |


## This module defines 1 resource.

| Resource | Description |
|------|-------------|
| aws_security_group.sg | Security Group |



<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE for full details.

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
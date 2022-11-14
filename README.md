# AWS EC2 SSH Bastion Terraform Module

Terraform module which creates EC2 instance as SSH Bastion

## Requirements

No requirements.

## Usage

```hcl
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "bastion" {
  count                   = 1
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 10, 888)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
}

module "bastion" {
  source        = "caherrera/bastion/aws"
  version       = "0.1.0"
  subnet_id     = aws_subnet.bastion[0].id
  name          = "Bastion"
  key_pair_name = "carlos-itline-key"

}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | terraform-aws-modules/ec2-instance/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_key_pair.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/key_pair) | data source |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | Use a custom ami | `string` | `null` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | If true this module will create an ec2 instance as bastion. If false just create a local-network instance | `bool` | `true` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | n/a | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for ec2 instance. also is prefix for SG | `string` | `"Bastion"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Public Subnet where bastion will live | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP address assigned to the instance. |

# Module: VPC

This module creates a Virtual Private Cloud (VPC) with public and private subnets across multiple availability zones.  
It includes NAT gateway configuration for internet access from private subnets and appropriate tags for Kubernetes
integration.

## Usage

```hcl
module "vpc" {
  source       = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/aws/vpc?ref=v1.0.0"
  organization = var.organization
  account      = var.account

  vpc = var.vpc
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space (CIDR block) for the virtual network (e.g., 10.0.0.0/16) | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The AWS region where the virtual network will be created (e.g., us-east-1, us-west-2) | `string` | n/a | yes |
| <a name="input_subnets_definition"></a> [subnets\_definition](#input\_subnets\_definition) | Subnet configuration for the virtual network including availability zones and CIDR blocks | <pre>object({<br/>    availability_zones = list(string)<br/>    private_subnets    = list(string)<br/>    public_subnets     = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the virtual network resources | `map(string)` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | List of private subnet IDs |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | List of public subnet IDs |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The resource ID of the virtual network. |
| <a name="output_subnet_ids_by_name"></a> [subnet\_ids\_by\_name](#output\_subnet\_ids\_by\_name) | Map of subnet names to their resource IDs |
<!-- END_TF_DOCS -->
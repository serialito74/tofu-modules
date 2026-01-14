# Module: EKS

This module provisions an Amazon Elastic Kubernetes Service (EKS) cluster with managed node groups or  automode. It includes
essential addons like CoreDNS, kube-proxy, and VPC-CNI, along with configurable managed node groups for workload
execution.

## Usage

```hcl
module "eks" {
  source                  = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/aws/eks?ref=v1.0.0"
  name                    = var.name
  kubernetes_version      = var.kubernetes_version
  aws_vpc_vpc_id          = var.aws_vpc_vpc_id
  aws_subnets_private_ids = var.aws_subnets_private_ids

  ami_type       = var.ami_type
  instance_types = var.instance_types
  use_auto_mode  = var.use_auto_mode # for default false
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
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 21.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_entries"></a> [access\_entries](#input\_access\_entries) | Map of access entries for the EKS cluster | <pre>map(object({<br/>    principal_arn     = string<br/>    user_name         = optional(string)<br/>    kubernetes_groups = optional(list(string))<br/>    type              = optional(string)<br/><br/>    policy_associations = optional(map(object({<br/>      policy_arn = string<br/>      access_scope = optional(object({<br/>        type       = optional(string)<br/>        namespaces = optional(list(string))<br/>      }))<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | AMI type to use with the node (e.g., AL2023\_x86\_64\_STANDARD) | `string` | `"AL2023_x86_64_STANDARD"` | no |
| <a name="input_auto_mode_enabled"></a> [auto\_mode\_enabled](#input\_auto\_mode\_enabled) | Whether to enable EKS Auto Mode instead of Managed Node Groups | `bool` | `false` | no |
| <a name="input_auto_mode_node_pools"></a> [auto\_mode\_node\_pools](#input\_auto\_mode\_node\_pools) | Node pools for Auto Mode | `list(string)` | <pre>[<br/>  "general-purpose",<br/>  "system"<br/>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | EC2 instance type to use for the node pool (e.g., t3.medium, m5.large) | `string` | `"t3.medium"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The version of Kubernetes to use for the EKS cluster | `string` | `"1.32"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the EKS cluster and related resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC/VNet where the EKS cluster will be deployed | `string` | n/a | yes |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | List of private subnet IDs for the EKS cluster and node groups | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | The cluster CA certificate in base64 |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_host"></a> [host](#output\_host) | The API server endpoint |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | ARN of the cluster's OIDC provider |
<!-- END_TF_DOCS -->
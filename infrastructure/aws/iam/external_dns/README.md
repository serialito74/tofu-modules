# Module: External DNS IAM

This module creates the IAM role and policy required for External DNS to manage Route 53 DNS records in AWS.
It uses IRSA (IAM Roles for Service Accounts) to provide secure access from the Kubernetes service account to AWS resources.

## Usage

```hcl
module "external_dns_iam" {
  source                              = "git::https://github.com/nullplatform/tofu-modules.git//infrastructure/aws/iam/external_dns?ref=v1.0.0"
  cluster_name                        = var.cluster_name
  aws_iam_openid_connect_provider_arn = var.aws_iam_openid_connect_provider_arn
  hosted_zone_public_id               = var.hosted_zone_public_id
  hosted_zone_private_id              = var.hosted_zone_private_id
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.28.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nullplatform_external_dns_role"></a> [nullplatform\_external\_dns\_role](#module\_nullplatform\_external\_dns\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.nullplatform_external_dns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster where external-dns runs | `string` | n/a | yes |
| <a name="input_dns_zone_private_id"></a> [dns\_zone\_private\_id](#input\_dns\_zone\_private\_id) | The ID of the private DNS zone for DNS management | `string` | n/a | yes |
| <a name="input_dns_zone_public_id"></a> [dns\_zone\_public\_id](#input\_dns\_zone\_public\_id) | The ID of the public DNS zone for DNS management | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the OIDC provider for EKS service account authentication | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nullplatform_external_dns_role_arn"></a> [nullplatform\_external\_dns\_role\_arn](#output\_nullplatform\_external\_dns\_role\_arn) | ARN of the external-dns role |
<!-- END_TF_DOCS -->

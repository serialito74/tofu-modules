
# Module: external_dns

This OpenTofu module installs **ExternalDNS** using a Helm chart, enabling dynamic DNS record management through
either **AWS Route53** or **Cloudflare** as your DNS provider.


## Usage

### AWS example

```hcl
module "external_dns" {
  source = "git::https://github.com/nullplatform/tofu-modules.git//infrastructure/commons/external_dns?ref=v1.0.0"

  dns_provider_name      = "aws"
  aws_region             = var.aws_region
  aws_iam_role_arn       = var.aws_iam_role_arn
  public_hosted_zone_id  = var.public_hosted_zone_id
  private_hosted_zone_id = var.private_hosted_zone_id
  domain_filters         = var.domain_filters
}
```

### Cloudflare example

```hcl
module "external_dns" {
  source = "git::https://github.com/nullplatform/tofu-modules.git//infrastructure/commons/external_dns?ref=v1.0.0"

  dns_provider_name = "cloudflare"
  cloudflare_token  = var.cloudflare_token
  domain_filters    = var.domain_filters
  aws_region        = var.aws_region
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.external_dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace_v1.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_secret_v1.external_dns_cloudflare](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_iam_role_arn"></a> [aws\_iam\_role\_arn](#input\_aws\_iam\_role\_arn) | The IAM role ARN for ExternalDNS to assume for Route53 access (required when dns\_provider is 'aws') | `string` | `null` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of ExternalDNS Helm chart to deploy | `string` | `"1.19.0"` | no |
| <a name="input_cloudflare_token"></a> [cloudflare\_token](#input\_cloudflare\_token) | The Cloudflare API token for DNS management (required when dns\_provider is 'cloudflare') | `string` | `null` | no |
| <a name="input_dns_provider"></a> [dns\_provider](#input\_dns\_provider) | The DNS provider to use with ExternalDNS (cloudflare or aws) | `string` | n/a | yes |
| <a name="input_dns_zone_private_id"></a> [dns\_zone\_private\_id](#input\_dns\_zone\_private\_id) | The Route53 private hosted zone ID for ExternalDNS to manage (required when dns\_provider is 'aws') | `string` | `""` | no |
| <a name="input_dns_zone_public_id"></a> [dns\_zone\_public\_id](#input\_dns\_zone\_public\_id) | The Route53 public hosted zone ID for ExternalDNS to manage (required when dns\_provider is 'aws') | `string` | `""` | no |
| <a name="input_domain_filters"></a> [domain\_filters](#input\_domain\_filters) | The domain filter to limit ExternalDNS to manage DNS records only for specific domains | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The AWS region where the Route53 hosted zones are located (required when dns\_provider is 'aws') | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace where ExternalDNS will be deployed | `string` | `"external-dns"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The policy for ExternalDNS to manage DNS records (create-only, sync, upsert-only) | `string` | `"upsert-only"` | no |
| <a name="input_sources"></a> [sources](#input\_sources) | The sources for ExternalDNS to watch for DNS records | `list(string)` | <pre>[<br/>  "crd"<br/>]</pre> | no |
| <a name="input_txt_owner_id"></a> [txt\_owner\_id](#input\_txt\_owner\_id) | The TXT owner ID used by ExternalDNS to identify DNS records it manages | `string` | `"external_dns"` | no |
<!-- END_TF_DOCS -->
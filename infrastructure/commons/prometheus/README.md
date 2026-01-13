# Module: Prometheus

Deploys **Prometheus** using Helm.

## Usage

```hcl
module "prometheus" {
  source               = "git::https://github.com/nullplatform/tofu-modules.git///infrastructure/commons/prometheus?ref=v1.0.0"
  prometheus_namespace = var.prometheus_namespace
  nullplatform_port    = var.nullplatform_port
}
```

***Important!***
This module only installs Prometheus; you must configure the metrics provider in order to integrate with Null Platform.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.prometheus](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace where Prometheus will be deployed | `string` | `"prometheus"` | no |
| <a name="input_nullplatform_port"></a> [nullplatform\_port](#input\_nullplatform\_port) | The port number for nullplatform service communication | `number` | `2021` | no |
<!-- END_TF_DOCS -->

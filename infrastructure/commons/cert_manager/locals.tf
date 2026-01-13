locals {
  common_context = {
    hosted_zone_name    = var.domain_name
    account_slug        = var.account_slug
    namespace           = var.namespace
    cloud_provider      = var.cloud_provider
    private_domain_name = var.private_domain_name
  }

  provider_context = merge(
    var.cloud_provider == "gcp" ? {
      enabled    = true
      project_id = var.project_id
    } : {},

    var.cloud_provider == "cloudflare" ? {
      enabled     = true
      secret_name = var.cloudflare_secret_name
      token       = var.cloudflare_token
    } : {},

    var.cloud_provider == "azure" ? {
      enabled             = true
      subscription_id     = var.subscription_id
      resource_group_name = var.resource_group_name
      client_id           = var.azure_client_id
      tenant_id           = var.azure_tenant_id
      hosted_zone_name    = var.azure_dns_zone_name
    } : {},

    var.cloud_provider == "aws" ? {
      enabled = true
      region  = var.location
    } : {}
  )

  cert_manager_default_values = templatefile(
    "${path.module}/templates/cert_manager_default_values.tmpl.yaml",
    local.common_context
  )

  cert_manager_provider_values = templatefile(
    "${path.module}/templates/cert_manager_${var.cloud_provider}_values.tmpl.yaml",
    local.provider_context
  )
}

###############################################################################
# CERT-MANAGER SERVICE ACCOUNT ANNOTATIONS
###############################################################################

locals {
  base_annotations = {
    "{{ .Chart.Name }}-helm-chart/version" = "{{ .Chart.Version }}"
  }

  annotations_by_provider = {
    gcp = {
      "iam.gke.io/gcp-service-account" = var.gcp_service_account_email
    }

    aws = {
      "eks.amazonaws.com/role-arn" = var.aws_iam_role_arn
    }

    azure = {
      "azure.workload.identity/client-id" = var.azure_client_id
    }
  }

  cert_manager_values = {
    crds = {
      enabled = true
    }
    serviceAccount = {
      create = true
      annotations = merge(
        local.base_annotations,
        lookup(local.annotations_by_provider, var.cloud_provider, {})
      )
    }
    dns01RecursiveNameservers     = "8.8.8.8:53,1.1.1.1:53"
    dns01RecursiveNameserversOnly = true
  }
}

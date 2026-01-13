###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "cloud_provider" {
  type        = string
  description = "The cloud provider to use (gcp, azure, aws, or cloudflare)"

  validation {
    condition     = contains(["gcp", "azure", "cloudflare", "aws"], var.cloud_provider)
    error_message = "The value must be one of: gcp, azure, cloudflare, aws."
  }
}

variable "domain_name" {
  type        = string
  description = "The hosted zone name for certificate issuance"
}

variable "private_domain_name" {
  type        = string
  description = "The private domain name for internal certificate issuance"
}

variable "account_slug" {
  type        = string
  description = "The nullplatform account slug"
}

###############################################################################
# OPTIONAL VARIABLES - HELM CONFIGURATION
###############################################################################

variable "chart_version" {
  type        = string
  description = "The version of cert-manager Helm chart to deploy"
  default     = "1.18.2"
}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace where cert-manager will be deployed"
  default     = "cert-manager"
}

variable "config_chart_version" {
  type        = string
  description = "The version of the cert-manager configuration Helm chart"
  default     = "2.29.2"
}

###############################################################################
# OPTIONAL VARIABLES - GCP CONFIGURATION
###############################################################################

variable "gcp_service_account_email" {
  type        = string
  description = "The GCP service account email for cert-manager (required when cloud_provider is 'gcp')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "gcp" || length(var.gcp_service_account_email) > 0
    error_message = "When cloud_provider is 'gcp', gcp_service_account_email must not be empty."
  }
}

variable "project_id" {
  type        = string
  description = "The GCP project ID for cert-manager DNS01 solver (required when cloud_provider is 'gcp')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "gcp" || length(var.project_id) > 0
    error_message = "When cloud_provider is 'gcp', project_id must not be empty."
  }
}

###############################################################################
# OPTIONAL VARIABLES - AWS CONFIGURATION
###############################################################################

variable "aws_iam_role_arn" {
  type        = string
  description = "The AWS IAM role ARN for cert-manager (required when cloud_provider is 'aws')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "aws" || length(var.aws_iam_role_arn) > 0
    error_message = "When cloud_provider is 'aws', aws_iam_role_arn must not be empty."
  }
}

variable "location" {
  type        = string
  description = "The AWS region (required when cloud_provider is 'aws')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "aws" || length(var.location) > 0
    error_message = "When cloud_provider is 'aws', location must not be empty."
  }
}

###############################################################################
# OPTIONAL VARIABLES - AZURE CONFIGURATION
###############################################################################

variable "azure_client_id" {
  type        = string
  description = "The Azure client ID for cert-manager (required when cloud_provider is 'azure')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "azure" || length(var.azure_client_id) > 0
    error_message = "When cloud_provider is 'azure', azure_client_id must not be empty."
  }
}

variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID (required when cloud_provider is 'azure')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "azure" || length(var.subscription_id) > 0
    error_message = "When cloud_provider is 'azure', subscription_id must not be empty."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group that contains the DNS zone (required when cloud_provider is 'azure')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "azure" || length(var.resource_group_name) > 0
    error_message = "When cloud_provider is 'azure', resource_group_name must not be empty."
  }
}

variable "azure_tenant_id" {
  type        = string
  description = "The Azure tenant ID (required when cloud_provider is 'azure')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "azure" || length(var.azure_tenant_id) > 0
    error_message = "When cloud_provider is 'azure', azure_tenant_id must not be empty."
  }
}

variable "azure_dns_zone_name" {
  type        = string
  description = "The hosted zone name in Azure DNS (required when cloud_provider is 'azure')"
  default     = ""

  validation {
    condition     = var.cloud_provider != "azure" || length(var.azure_dns_zone_name) > 0
    error_message = "When cloud_provider is 'azure', azure_dns_zone_name must not be empty."
  }
}

###############################################################################
# OPTIONAL VARIABLES - CLOUDFLARE CONFIGURATION
###############################################################################

variable "cloudflare_secret_name" {
  type        = string
  description = "The name of the Kubernetes secret that stores the Cloudflare API token"
  default     = "cloudflare-api-token-secret"
}

variable "cloudflare_token" {
  type        = string
  description = "The Cloudflare API token (minimum permissions: Zone:DNS:Edit and Zone:Read)"
  sensitive   = true
  default     = ""

  validation {
    condition     = var.cloud_provider != "cloudflare" || length(var.cloudflare_token) > 0
    error_message = "When cloud_provider is 'cloudflare', cloudflare_token must not be empty."
  }
}

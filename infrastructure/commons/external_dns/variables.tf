###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "dns_provider" {
  type        = string
  description = "The DNS provider to use with ExternalDNS (cloudflare or aws)"

  validation {
    condition     = contains(["cloudflare", "aws"], var.dns_provider)
    error_message = "dns_provider must be either 'cloudflare' or 'aws'."
  }
}

variable "domain_filters" {
  type        = string
  description = "The domain filter to limit ExternalDNS to manage DNS records only for specific domains"
}

###############################################################################
# OPTIONAL VARIABLES - HELM CONFIGURATION
###############################################################################

variable "chart_version" {
  type        = string
  description = "The version of ExternalDNS Helm chart to deploy"
  default     = "1.19.0"
}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace where ExternalDNS will be deployed"
  default     = "external-dns"
}

###############################################################################
# OPTIONAL VARIABLES - EXTERNAL DNS CONFIGURATION
###############################################################################

variable "txt_owner_id" {
  type        = string
  description = "The TXT owner ID used by ExternalDNS to identify DNS records it manages"
  default     = "external_dns"
}

variable "policy" {
  type        = string
  description = "The policy for ExternalDNS to manage DNS records (create-only, sync, upsert-only)"
  default     = "upsert-only"

  validation {
    condition     = contains(["create-only", "sync", "upsert-only"], var.policy)
    error_message = "policy must be either 'create-only', 'sync', or 'upsert-only'."
  }
}

variable "sources" {
  type        = list(string)
  description = "The sources for ExternalDNS to watch for DNS records"
  default     = ["crd"]
}

###############################################################################
# OPTIONAL VARIABLES - AWS CONFIGURATION
###############################################################################

variable "location" {
  type        = string
  description = "The AWS region where the Route53 hosted zones are located (required when dns_provider is 'aws')"
  default     = null

  validation {
    condition     = var.dns_provider != "aws" || var.location != null
    error_message = "location is required when dns_provider is 'aws'."
  }
}

variable "aws_iam_role_arn" {
  type        = string
  description = "The IAM role ARN for ExternalDNS to assume for Route53 access (required when dns_provider is 'aws')"
  default     = null

  validation {
    condition     = var.dns_provider != "aws" || var.aws_iam_role_arn != null
    error_message = "aws_iam_role_arn is required when dns_provider is 'aws'."
  }
}

variable "dns_zone_public_id" {
  type        = string
  description = "The Route53 public hosted zone ID for ExternalDNS to manage (required when dns_provider is 'aws')"
  default     = ""

  validation {
    condition     = var.dns_provider != "aws" || var.dns_zone_public_id != ""
    error_message = "dns_zone_public_id is required when dns_provider is 'aws'."
  }
}

variable "dns_zone_private_id" {
  type        = string
  description = "The Route53 private hosted zone ID for ExternalDNS to manage (required when dns_provider is 'aws')"
  default     = ""

  validation {
    condition     = var.dns_provider != "aws" || var.dns_zone_private_id != ""
    error_message = "dns_zone_private_id is required when dns_provider is 'aws'."
  }
}

###############################################################################
# OPTIONAL VARIABLES - CLOUDFLARE CONFIGURATION
###############################################################################

variable "cloudflare_token" {
  type        = string
  description = "The Cloudflare API token for DNS management (required when dns_provider is 'cloudflare')"
  sensitive   = true
  default     = null

  validation {
    condition     = var.dns_provider != "cloudflare" || var.cloudflare_token != null
    error_message = "cloudflare_token is required when dns_provider is 'cloudflare'."
  }
}

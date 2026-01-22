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

variable "type" {
  description = "Determines whether the external-dns deployment is public or private"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private"], var.type)
    error_message = "The \"type\" variable must be either \"public\" or \"private\"."
  }
}

###############################################################################
# OPTIONAL VARIABLES - AWS CONFIGURATION
###############################################################################

variable "location" {
  type        = string
  description = "The AWS region where the Route53 hosted zones are located (required when dns_provider is 'aws')"
  default     = null

###############################################################################
# AWS CONFIGURATION
###############################################################################

variable "aws_region" {
  description = "The AWS region where the Route53 hosted zones are located"
  type        = string
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

variable "zone_id_filter" {
  description = "The Route53 public or private hosted zone ID for ExternalDNS to manage (required when dns_provider_name is 'aws')"
  type        = string
  description = "The Route53 public hosted zone ID for ExternalDNS to manage (required when dns_provider is 'aws')"
  default     = ""

  validation {
    condition     = var.dns_provider_name != "aws" || var.zone_id_filter != ""
    error_message = "zone_id_filter is required when dns_provider_name is 'aws'."
  }
}

variable "zone_type" {
  description = "The Route53 hosted zone type for ExternalDNS to manage (public or private)"
  type        = string
  description = "The Route53 private hosted zone ID for ExternalDNS to manage (required when dns_provider is 'aws')"
  default     = ""

  validation {
    condition = (
    var.dns_provider_name != "aws" || (var.zone_type != "" && contains(["public", "private"], lower(var.zone_type))))
    error_message = "When dns_provider_name is 'aws', zone_type must be 'public' or 'private'."
  }
}

###############################################################################
# OCI CONFIGURATION
###############################################################################

variable "oci_compartment_ocid" {
  description = "The OCI compartment OCID where the DNS zones are located (required when dns_provider_name is 'oci')"
  type        = string
  default     = null
  validation {
    condition     = var.dns_provider_name != "oci" || var.oci_compartment_ocid != null
    error_message = "oci_compartment_ocid is required when dns_provider_name is 'oci'."
  }
}

variable "oci_region" {
  description = "The OCI region for workload identity configuration (required when dns_provider_name is 'oci')"
  type        = string
  default     = null
  validation {
    condition     = var.dns_provider_name != "oci" || var.oci_region != null
    error_message = "oci_region is required when dns_provider_name is 'oci'."
  }
}

variable "oci_service_account_name" {
  description = "The Kubernetes service account name for OCI Workload Identity"
  type        = string
  default     = "external-dns"
}

variable "oci_zone_scope" {
  description = "The scope of the DNS zones in OCI (GLOBAL or PRIVATE)"
  type        = string
  default     = "GLOBAL"
  validation {
    condition     = contains(["GLOBAL", "PRIVATE"], var.oci_zone_scope)
    error_message = "oci_zone_scope must be either 'GLOBAL' or 'PRIVATE'."
  }
}

variable "oci_zones_cache_duration" {
  description = "The duration to cache OCI DNS zones (e.g., '30s', '1m'). Set to '0s' to disable caching."
  type        = string
  default     = "30s"
}

###############################################################################
# DNS PROVIDER CONFIGURATION
###############################################################################

variable "cloudflare_token" {
  type        = string
  description = "The Cloudflare API token for DNS management (required when dns_provider is 'cloudflare')"
  sensitive   = true
  default     = null

  validation {
    condition     = contains(["cloudflare", "aws", "oci"], var.dns_provider_name)
    error_message = "dns_provider_name must be either 'cloudflare', 'aws', or 'oci'."
  }
}

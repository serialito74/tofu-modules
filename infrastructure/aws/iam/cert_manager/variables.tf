###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster where cert-manager runs"
}

variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC provider for EKS service account authentication"
}

variable "dns_zone_public_id" {
  type        = string
  description = "The ID of the public DNS zone for DNS validation"
}

variable "dns_zone_private_id" {
  type        = string
  description = "The ID of the private DNS zone for DNS validation"
}

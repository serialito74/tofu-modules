###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster where external-dns runs"
}

variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC provider for EKS service account authentication"
}

variable "dns_zone_public_id" {
  type        = string
  description = "The ID of the public DNS zone for DNS management"
}

variable "dns_zone_private_id" {
  type        = string
  description = "The ID of the private DNS zone for DNS management"
}

###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster where the agent runs"
}

variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC provider for EKS service account authentication"
}

variable "agent_namespace" {
  type        = string
  description = "The Kubernetes namespace where the agent runs"
}

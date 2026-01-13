###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC/VNet where load balancers will be deployed"
}

variable "oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC provider for EKS cluster authentication"
}

###############################################################################
# OPTIONAL VARIABLES - HELM CONFIGURATION
###############################################################################

variable "chart_aws_load_balancer_controller_version" {
  type        = string
  description = "The version of the AWS Load Balancer Controller Helm chart"
  default     = "1.13.4"
}
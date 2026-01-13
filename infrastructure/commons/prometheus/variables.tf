###############################################################################
# OPTIONAL VARIABLES - HELM CONFIGURATION
###############################################################################

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace where Prometheus will be deployed"
  default     = "prometheus"
}

###############################################################################
# OPTIONAL VARIABLES - SERVICE CONFIGURATION
###############################################################################

variable "nullplatform_port" {
  type        = number
  description = "The port number for nullplatform service communication"
  default     = 2021
}

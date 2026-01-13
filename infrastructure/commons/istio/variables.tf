###############################################################################
# OPTIONAL VARIABLES - HELM CONFIGURATION
###############################################################################

variable "chart_version" {
  type        = string
  description = "The version of Istio Helm charts to deploy"
  default     = "1.27.1"
}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace where Istio will be installed"
  default     = "istio-system"
}

variable "repository" {
  type        = string
  description = "The Helm repository URL for Istio charts"
  default     = "https://istio-release.storage.googleapis.com/charts"
}

###############################################################################
# OPTIONAL VARIABLES - SERVICE CONFIGURATION
###############################################################################

variable "service_type" {
  type        = string
  description = "The Kubernetes service type for the Istio ingress gateway"
  default     = "LoadBalancer"
}

variable "status_port" {
  type        = number
  description = "The status port for health checks"
  default     = 15021
}

variable "https_port" {
  type        = number
  description = "The external HTTPS service port"
  default     = 443
}

variable "https_target_port" {
  type        = number
  description = "The container target port for HTTPS"
  default     = 8443
}

###############################################################################
# OPTIONAL VARIABLES - HTTP2 CONFIGURATION
###############################################################################

variable "http2_enabled" {
  type        = bool
  description = "Whether to expose the HTTP2 (port 80) service"
  default     = false
}

variable "http2_port" {
  type        = number
  description = "The external service port for HTTP2 when enabled"
  default     = 80
}

variable "http2_target_port" {
  type        = number
  description = "The container target port for HTTP2 when enabled"
  default     = 80
}

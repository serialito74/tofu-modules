###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "certificate_arn" {
  type        = string
  description = "The ARN of the SSL/TLS certificate for the ingress"
}
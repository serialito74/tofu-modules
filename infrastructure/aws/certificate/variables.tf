###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "domain_name" {
  type        = string
  description = "The domain name for which to request the SSL certificate"
}

variable "dns_zone_id" {
  type        = string
  description = "The ID of the DNS zone where certificate will be validated"
}

###############################################################################
# OPTIONAL VARIABLES - CERTIFICATE CONFIGURATION
###############################################################################

variable "subject_alternative_names" {
  type        = list(string)
  description = "Alternative DNS names to add to the certificate"
  default     = []
}

###############################################################################
# OPTIONAL VARIABLES - TAGS AND METADATA
###############################################################################

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the certificate"
  default     = {}
}

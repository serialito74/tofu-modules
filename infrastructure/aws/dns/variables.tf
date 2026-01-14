###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "domain_name" {
  type        = string
  description = "The domain name to use for the DNS zone (e.g., example.com)"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC/VNet for private DNS zone association"
}

###############################################################################
# OPTIONAL VARIABLES - TAGS
###############################################################################

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the DNS zone"
  default     = {}
}

###############################################################################
# NOTE: resource_group_name
# In Azure, resources are organized into resource groups. AWS does not have
# this concept - resources are organized by region and account. Tags can be
# used for logical grouping in AWS.
###############################################################################

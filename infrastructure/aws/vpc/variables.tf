###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "address_space" {
  type        = string
  description = "The address space (CIDR block) for the virtual network (e.g., 10.0.0.0/16)"
}

variable "subnets_definition" {
  type = object({
    availability_zones = list(string)
    private_subnets    = list(string)
    public_subnets     = list(string)
  })
  description = "Subnet configuration for the virtual network including availability zones and CIDR blocks"
}

# Example:
# subnets_definition = {
#   availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
#   private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
# }

###############################################################################
# OPTIONAL VARIABLES - TAGS
###############################################################################

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the virtual network resources"
  default     = {}
}

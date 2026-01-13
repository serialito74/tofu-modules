###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC/VNet where the EKS cluster will be deployed"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the EKS cluster and node groups"
}

###############################################################################
# OPTIONAL VARIABLES - KUBERNETES CONFIGURATION
###############################################################################

variable "kubernetes_version" {
  type        = string
  description = "The version of Kubernetes to use for the EKS cluster"
  default     = "1.32"
}

###############################################################################
# OPTIONAL VARIABLES - NODE POOLS
###############################################################################

variable "ami_type" {
  type        = string
  description = "AMI type to use with the node (e.g., AL2023_x86_64_STANDARD)"
  default     = "AL2023_x86_64_STANDARD"
}

variable "instance_types" {
  type        = string
  description = "EC2 instance type to use for the node pool (e.g., t3.medium, m5.large)"
  default     = "t3.medium"
}

variable "auto_mode_enabled" {
  type        = bool
  description = "Whether to enable EKS Auto Mode instead of Managed Node Groups"
  default     = false
}

variable "auto_mode_node_pools" {
  type        = list(string)
  description = "Node pools for Auto Mode"
  default     = ["general-purpose", "system"]
}

###############################################################################
# OPTIONAL VARIABLES - IDENTITY AND RBAC
###############################################################################

variable "access_entries" {
  type = map(object({
    principal_arn     = string
    user_name         = optional(string)
    kubernetes_groups = optional(list(string))
    type              = optional(string)

    policy_associations = optional(map(object({
      policy_arn = string
      access_scope = optional(object({
        type       = optional(string)
        namespaces = optional(list(string))
      }))
    })))
  }))
  description = "Map of access entries for the EKS cluster"
  default     = {}
}

###############################################################################
# OPTIONAL VARIABLES - TAGS AND METADATA
###############################################################################

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the EKS cluster and related resources"
  default     = {}
}
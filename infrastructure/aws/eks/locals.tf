locals {
  # EKS Managed Node Group(s)
  eks_managed_node_groups = var.auto_mode_enabled ? {} : {
    default = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = var.ami_type
      instance_types = [var.instance_types]

      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }
}

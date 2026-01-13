module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  create_cloudwatch_log_group = false

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  access_entries = var.access_entries
  enable_irsa    = true
  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.vpc_subnet_ids
  control_plane_subnet_ids = var.vpc_subnet_ids

  # Reglas adicionales para webhooks (Istio, cert-manager, etc.)
  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane_to_webhooks = {
      description                   = "Allow access from control plane to admission webhooks"
      protocol                      = "tcp"
      from_port                     = 15017
      to_port                       = 15017
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = var.auto_mode_enabled ? {} : {
    nullplatform = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = var.ami_type
      instance_types = [var.instance_types]

      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }
  # ==========================================
  #  AUTO MODE
  # ==========================================
  create_auto_mode_iam_resources = var.auto_mode_enabled ? true : false

  compute_config = var.auto_mode_enabled ? {
    enabled    = true
    node_pools = var.auto_mode_node_pools
    } : {
    enabled    = false
    node_pools = []
  }

  tags = var.tags
}

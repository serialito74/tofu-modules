module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = var.vnet_name
  cidr = var.address_space

  enable_dns_hostnames = true

  azs             = var.subnets_definition.availability_zones
  private_subnets = var.subnets_definition.private_subnets
  public_subnets  = var.subnets_definition.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = var.tags
}

output "resource_id" {
  description = "The resource ID of the virtual network."
  value       = module.vpc.vpc_id
}

output "subnet_ids_by_name" {
  description = "Map of subnet names to their resource IDs"
  value = {
    private = module.vpc.private_subnets
    public  = module.vpc.public_subnets
  }
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

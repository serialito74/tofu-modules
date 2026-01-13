output "host" {
  value       = module.eks.cluster_endpoint
  description = "The API server endpoint"
}

output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}

output "cluster_ca_certificate" {
  value       = module.eks.cluster_certificate_authority_data
  description = "The cluster CA certificate in base64"
  sensitive   = true
}

output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "ARN of the cluster's OIDC provider"
}

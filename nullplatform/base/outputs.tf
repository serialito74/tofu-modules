############################################
# Rendered Helm Values (used in tests)
############################################

output "rendered_values" {
  description = "The rendered Helm values passed to the base chart."
  value       = local.nullplatform_base_values
  sensitive   = true
}

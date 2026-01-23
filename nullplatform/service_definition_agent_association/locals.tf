locals {
  # Build overrides flag only when override feature is enabled
  overrides_flag = var.enabled_override ? "--overrides-path=${var.override_repo_path}${var.overrides_service_path}" : ""

  # Default notification channel definition - no external template needed
  notification_channel_def = {
    nrn    = var.nrn
    status = "active"
    type   = var.channel_type
    source = var.channel_sources
    configuration = {
      api_key = module.api_key.api_key
      command = {
        type = "exec"
        data = {
          cmdline     = "${var.repo_path}/databases/${var.service_specification_slug}/k8s/handle-service-agent"
          environment = {
            NP_ACTION_CONTEXT = "'$${NOTIFICATION_CONTEXT}'"
          }
        }
      }
      selector = var.tags_selectors
    }
    filters = {
      "$or" = [
        {
          "service.specification.slug" = var.service_specification_slug
        },
        {
          "arguments.scope_provider" = var.service_specification_id
        }
      ]
    }
  }
}

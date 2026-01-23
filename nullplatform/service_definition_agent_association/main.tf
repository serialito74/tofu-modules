################################################################################
# Notification Channel Resource
################################################################################
resource "nullplatform_notification_channel" "channel" {
  nrn    = var.nrn
  type   = local.notification_channel_def.type
  source = local.notification_channel_def.source

  configuration {
    agent {
      api_key = local.notification_channel_def.configuration.api_key
      command {
        type = local.notification_channel_def.configuration.command.type
        data = {
          cmdline = var.enabled_override ? "${local.notification_channel_def.configuration.command.data.cmdline} ${local.overrides_flag}" : local.notification_channel_def.configuration.command.data.cmdline
          environment = jsonencode({
            NP_ACTION_CONTEXT = "'$${NOTIFICATION_CONTEXT}'"
          })
        }
      }
      selector = var.tags_selectors
    }
  }

  filters = jsonencode(local.notification_channel_def.filters)

  lifecycle {
    ignore_changes = [
      filters,
      source,
      type,
    ]
  }
}

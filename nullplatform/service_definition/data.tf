# Fetch service specification template
data "github_repository_file" "service_spec_template" {
  repository = var.git_repo
  branch     = var.git_ref
  file       = "${var.git_service_path}/specs/service-spec.json${var.use_tpl_files ? ".tpl" : ""}"
}

# Fetch link specification template (only if service has links)
data "github_repository_file" "link_spec_template" {
  count      = local.has_links ? 1 : 0
  repository = var.git_repo
  branch     = var.git_ref
  file       = "${var.git_service_path}/specs/link-spec.json${var.use_tpl_files ? ".tpl" : ""}"
}

# Fetch action specification templates
data "github_repository_file" "action_templates" {
  for_each   = toset(local.available_actions)
  repository = var.git_repo
  branch     = var.git_ref
  file       = "${var.git_service_path}/specs/actions/${each.key}.json${var.use_tpl_files ? ".tpl" : ""}"
}

# Fetch link specification templates (only if service has links)
data "github_repository_file" "link_templates" {
  for_each   = toset(local.available_links)
  repository = var.git_repo
  branch     = var.git_ref
  file       = "${var.git_service_path}/specs/links/${each.key}.json${var.use_tpl_files ? ".tpl" : ""}"
}

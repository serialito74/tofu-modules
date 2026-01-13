

locals {
  
  service_spec_rendered = var.use_tpl_files ? replace(
    data.github_repository_file.service_spec_template.content,
    "/\"{{\\s+env.Getenv\\s+\".*\"\\s+}}\"/",
    "\"${var.nrn}\""
  ) : data.github_repository_file.service_spec_template.content
  service_spec_parsed = jsondecode(local.service_spec_rendered)
  available_actions   = try(local.service_spec_parsed.available_actions, [])
  available_links     = try(local.service_spec_parsed.available_links, [])
  has_links           = length(local.available_links) > 0
  visible_to_nrns     = concat([var.nrn], var.extra_visibile_to_nrns)


  # Process link spec template only if service has links
  link_spec_rendered = local.has_links ? (var.use_tpl_files ? replace(
    data.github_repository_file.link_spec_template[0].content,
    "/\"{{\\s+env.Getenv\\s+\".*\"\\s+}}\"/",
    "\"${var.nrn}\""
  ) : data.github_repository_file.link_spec_template[0].content) : "{}"
  link_spec_parsed = local.has_links ? jsondecode(local.link_spec_rendered) : {}

  # Variables that depend on created service specification
  service_specification_id = nullplatform_service_specification.from_template.id
  service_slug             = nullplatform_service_specification.from_template.slug

  dependent_env_vars = {
    NRN                      = var.nrn
    SERVICE_SPECIFICATION_ID = local.service_specification_id
    SERVICE_SLUG             = local.service_slug
  }

  action_specs_parsed = {
    for name in local.available_actions :
    name => jsondecode(var.use_tpl_files ? replace(
      data.github_repository_file.action_templates[name].content,
      "/\"{{\\s+env.Getenv\\s+\".*\"\\s+}}\"/",
      "\"\""
    ) : data.github_repository_file.action_templates[name].content)
  }

  link_specs_parsed = {
    for name in local.available_links :
    name => jsondecode(var.use_tpl_files ? replace(
      data.github_repository_file.link_templates[name].content,
      "/\"{{\\s+env.Getenv\\s+\".*\"\\s+}}\"/",
      "\"\""
    ) : data.github_repository_file.link_templates[name].content)
  }
}
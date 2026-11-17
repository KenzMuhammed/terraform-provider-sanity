terraform {
  required_providers {
    sanity = {
      source = "kenzmuhammed/sanity"
    }
  }
}

# Provider reads SANITY_TOKEN from environment.
# Never hardcode the token here — set it via:
#   export SANITY_TOKEN="<your-token>"
provider "sanity" {}

# ---------------------------------------------------------------------------
# Environment-Specific Config Parsing
# All values flow from sanity-iac-config.json.
# No values are hardcoded in any .tf file.
# ---------------------------------------------------------------------------
locals {
  config = jsondecode(file("${path.module}/sanity-iac-config.json"))

  project_id = local.config.project.id

  # 1. Datasets: One dataset per environment
  datasets = {
    for env_name, env_cfg in local.config.environments :
    try(env_cfg.dataset_name, env_name) => {
      name     = try(env_cfg.dataset_name, env_name)
      acl_mode = env_cfg.acl_mode
    }
  }

  # 2. CORS Origins: Merged from environment-specific origins + common origins
  cors_origins = merge(
    # Environment-specific CORS origins
    merge([
      for env_name, env_cfg in local.config.environments : {
        for c in try(env_cfg.cors_origins, []) :
        c.origin => c
      }
    ]...),
    # Common CORS origins (e.g. localhost studio)
    {
      for c in try(local.config.common.cors_origins, []) :
      c.origin => c
    }
  )

  # 3. Webhooks: From each environment that defines a webhook block
  # (Automatically targets that environment's dataset!)
  webhooks = {
    for env_name, env_cfg in local.config.environments :
    env_cfg.webhook.name => merge(env_cfg.webhook, { dataset = env_name })
    if try(env_cfg.webhook, null) != null
  }

  # 4. Invitations: From common
  invitations = {
    for i in try(local.config.common.invitations, []) :
    i.email => i
  }
}

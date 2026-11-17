# ---------------------------------------------------------------------------
# Webhooks
# ---------------------------------------------------------------------------
# One resource instance per entry in config.webhooks[].
# The for_each key is the webhook name — must be unique within the project.
#
# Fields that can be updated in-place (PATCH): name, url, dataset, http_method,
# secret, filter, projection, include_drafts, include_all_versions,
# is_disabled_by_user.
#
# `api_version` in the payload controls which GROQ API version evaluates the
# filter and projection expressions (e.g. "v2024-01-01").
# ---------------------------------------------------------------------------

resource "sanity_webhook" "this" {
  for_each = local.webhooks

  project_id           = local.project_id
  name                 = each.value.name
  url                  = each.value.url
  dataset              = each.value.dataset
  api_version          = each.value.api_version
  http_method          = each.value.http_method
  secret               = each.value.secret
  include_drafts       = each.value.include_drafts
  include_all_versions = each.value.include_all_versions
  is_disabled_by_user  = each.value.is_disabled_by_user

  # Ensure target datasets exist before webhooks subscribe to them
  depends_on = [sanity_dataset.this]
}

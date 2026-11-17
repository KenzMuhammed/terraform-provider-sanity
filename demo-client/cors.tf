# ---------------------------------------------------------------------------
# CORS Origins
# ---------------------------------------------------------------------------
# One resource instance per entry in config.cors_origins[].
# The for_each key is the origin URL — unique and stable.
#
# Sanity CORS entries have no update endpoint; changing origin or
# allow_credentials forces a delete+recreate (RequiresReplace is set in the
# provider). Adjust config.cors_origins[] to add, remove, or replace origins.
# ---------------------------------------------------------------------------

resource "sanity_cors_origin" "this" {
  for_each = local.cors_origins

  project_id        = local.project_id
  origin            = each.value.origin
  allow_credentials = each.value.allow_credentials
}

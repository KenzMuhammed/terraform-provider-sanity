# ---------------------------------------------------------------------------
# Datasets
# ---------------------------------------------------------------------------
# One resource instance per entry in config.datasets[].
# The for_each key is the dataset name — stable and meaningful.
#
# IMPORT NOTE: If a dataset already exists (e.g. "production"), import it
# before the first apply so Terraform manages it without recreating it:
#
#   terraform import 'sanity_dataset.this["production"]' <project_id>/<name>
#
# After import, `terraform plan` must show zero changes before applying.
# ---------------------------------------------------------------------------

resource "sanity_dataset" "this" {
  for_each = local.datasets

  project_id = local.project_id
  name       = each.value.name
  acl_mode   = each.value.acl_mode
}

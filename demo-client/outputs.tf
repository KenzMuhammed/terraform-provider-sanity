# ---------------------------------------------------------------------------
# Outputs
# ---------------------------------------------------------------------------
# All output values are derived purely from resource state — nothing is
# hardcoded.
# ---------------------------------------------------------------------------

output "project_id" {
  description = "The Sanity project ID."
  value       = local.project_id
}

output "project_name" {
  description = "The name of the Sanity project."
  value       = local.config.project.project_name
}

output "dataset_ids" {
  description = "Map of dataset name → Terraform resource ID (format: <project_id>/<name>)."
  value       = { for k, v in sanity_dataset.this : k => v.id }
}

output "cors_origin_ids" {
  description = "Map of origin URL → Sanity CORS numeric ID."
  value       = { for k, v in sanity_cors_origin.this : k => v.id }
}

output "webhook_ids" {
  description = "Map of webhook name → Sanity webhook ID."
  value       = { for k, v in sanity_webhook.this : k => v.id }
}

output "invitation_ids" {
  description = "Map of invited email → invitation ID."
  value       = { for k, v in sanity_project_invitation.this : k => v.id }
}

# ---------------------------------------------------------------------------
# Project Member Invitations
# ---------------------------------------------------------------------------
# One resource instance per entry in config.invitations[].
# The for_each key is the invited email — unique within a project.
#
# Lifecycle notes:
#   - Create: sends the invitation email and stores the invitation ID in state.
#   - Read:   polls the pending invitation; once accepted, is_accepted = true.
#   - Delete: revokes the pending invitation (sets is_revoked = true).
#   - Update: changing email or role requires replacement (new invite is sent).
#
# To stop managing an invitation without revoking it, use `terraform state rm`.
# ---------------------------------------------------------------------------

resource "sanity_project_invitation" "this" {
  for_each = local.invitations

  project_id = local.project_id
  email      = each.value.email
  role       = each.value.role
}

terraform {
  required_providers {
    sanity = {
      source = "kenzmuhammed/sanity"
    }
  }
}

provider "sanity" {}

resource "sanity_project_invitation" "qa_lead" {
  project_id = "72xj82oo"
  email      = "qa-engineer@example.com"
  role       = "viewer"
}

output "invite_id" {
  value = sanity_project_invitation.qa_lead.id
}

output "invite_email" {
  value = sanity_project_invitation.qa_lead.email
}

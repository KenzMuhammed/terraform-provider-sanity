terraform {
  required_providers {
    sanity = {
      source = "kenzmuhammed/sanity"
    }
  }
}

provider "sanity" {
  # Automatically reads SANITY_TOKEN from environment
}

# 1. Read existing project data source
data "sanity_project" "test" {
  id = "72xj82oo"
}

# 2. Manage a CORS origin
resource "sanity_cors_origin" "local_test" {
  project_id        = data.sanity_project.test.id
  origin            = "http://localhost:8080"
  allow_credentials = false
}

output "project_display_name" {
  value = data.sanity_project.test.display_name
}

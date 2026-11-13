terraform {
  required_providers {
    sanity = {
      source = "kenzmuhammed/sanity"
    }
  }
}

provider "sanity" {}

# 1. Project Reference
data "sanity_project" "main" {
  id = "72xj82oo"
}

# 2. Dataset on the Project
resource "sanity_dataset" "feature" {
  project_id = data.sanity_project.main.id
  name       = "feature"
  acl_mode   = "public"
}

# 3. CORS Origin for the feature frontend
resource "sanity_cors_origin" "frontend" {
  project_id        = data.sanity_project.main.id
  origin            = "https://feature-test.example.com"
  allow_credentials = false
}

# 4. Webhook subscribed to the feature dataset with valid DNS URL
resource "sanity_webhook" "feature_hook" {
  project_id  = data.sanity_project.main.id
  name        = "Feature Build Webhook"
  url         = "https://example.com/deploy"
  dataset     = sanity_dataset.feature.name
  api_version = "v2024-01-01"
  http_method = "POST"
  secret      = "grand-e2e-secret-key-12345"
}

output "project_name" {
  value = data.sanity_project.main.display_name
}

output "feature_dataset_id" {
  value = sanity_dataset.feature.id
}

output "cors_id" {
  value = sanity_cors_origin.frontend.id
}

output "webhook_id" {
  value = sanity_webhook.feature_hook.id
}

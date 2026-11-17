# Fetch an existing project by ID
data "sanity_project" "existing" {
  id = "72xj82oo"
}

output "project_name" {
  value = data.sanity_project.existing.project_name
}

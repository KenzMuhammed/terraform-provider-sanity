# Create a new Sanity project
resource "sanity_project" "example" {
  display_name    = "Production Application"
  organization_id = "o1nhulfhp"
}

# Reference the created project ID in other resources:
# output "project_id" {
#   value = sanity_project.example.id
# }

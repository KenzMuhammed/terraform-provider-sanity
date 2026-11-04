# Look up an existing dataset
data "sanity_dataset" "prod" {
  project_id = "72xj82oo"
  name       = "production"
}

output "is_dataset_public" {
  value = data.sanity_dataset.prod.acl_mode == "public"
}

# demo-client — Sanity IaC Standard Template

This folder is both the **integration test** for `terraform-provider-sanity` and the **reusable standard template** for provisioning Sanity infrastructure for any client.

It follows the same config-driven convention used in `streakjs-common-infra` for Cloudflare provisioning:  
**all client-specific values live in `sanity-iac-config.json` — zero hardcoding in `.tf` files.**

---

## What it provisions

| Resource | Description |
|---|---|
| `sanity_dataset` | One dataset per entry in `datasets[]` |
| `sanity_cors_origin` | One CORS origin per entry in `cors_origins[]` |
| `sanity_webhook` | One webhook per entry in `webhooks[]` |
| `sanity_project_invitation` | One member invitation per entry in `invitations[]` |

The project itself is **referenced by ID** (`local.project_id`).  
To manage an existing project's metadata, use `data.sanity_project` or `sanity_project` with `terraform import`.

---

## File layout

```
demo-client/
├── sanity-iac-config.json   ← THE ONLY FILE YOU CHANGE PER CLIENT
├── main.tf                  ← Provider config + locals that parse the JSON
├── datasets.tf              ← sanity_dataset resources (for_each)
├── cors.tf                  ← sanity_cors_origin resources (for_each)
├── webhooks.tf              ← sanity_webhook resources (for_each)
├── members.tf               ← sanity_project_invitation resources (for_each)
└── outputs.tf               ← All outputs derived from resource state
```

---

## Prerequisites

- Terraform ≥ 1.3 (for `for_each` on `jsondecode` maps)
- A Sanity API token with Administrator rights on the target project
- An existing Sanity project ID

---

## Usage: new client

1. **Copy this folder** to a new directory named after your client:
   ```bash
   cp -r demo-client clients/acme-corp
   ```

2. **Edit `sanity-iac-config.json`** — update `project.id`, dataset names, CORS origins, webhooks, and invitations for the new client. That's the only file you touch.

3. **Export your token:**
   ```bash
   export SANITY_TOKEN="<administrator-token-for-the-project>"
   ```

4. **Initialize:**
   ```bash
   cd clients/acme-corp
   terraform init
   ```

5. **Import pre-existing resources** (if any exist, e.g. a default `production` dataset created with the project):
   ```bash
   terraform import 'sanity_dataset.this["production"]' <project_id>/production
   ```

6. **Apply:**
   ```bash
   terraform apply
   ```

7. **Verify zero-drift:**
   ```bash
   terraform plan
   # Expected: No changes.
   ```

---

## Integration test run (demo-client)

This template is verified live against Sanity project `jqc54gp8`.

```bash
cd demo-client
terraform init

# Full apply — provisions datasets, CORS origins, webhooks, and invitations
TF_CLI_CONFIG_FILE=../terraformrc.dev \
SANITY_TOKEN="<token>" \
terraform apply -auto-approve

# Idempotency check — must return zero changes
TF_CLI_CONFIG_FILE=../terraformrc.dev \
SANITY_TOKEN="<token>" \
terraform plan

# Clean destroy — tears down all created resources in reverse dependency order
TF_CLI_CONFIG_FILE=../terraformrc.dev \
SANITY_TOKEN="<token>" \
terraform destroy -auto-approve
```

---

## Extending the config

To add a new dataset, CORS origin, webhook, or invitation, **only edit `sanity-iac-config.json`**.  
No `.tf` files need to change. `terraform apply` will create the new resource.

To remove one, delete its entry from the JSON and run `terraform apply` — the resource is destroyed cleanly.

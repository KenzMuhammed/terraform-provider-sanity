# Terraform Provider for Sanity.io

A production-grade, open-source Terraform provider for managing [Sanity.io](https://www.sanity.io) platform infrastructure, built with the modern Terraform Plugin Framework and Protocol v6.

## Features

- **Project Management:** Provision and manage Sanity projects declaratively.
- **Dataset Management:** Configure datasets with fine-grained access control (`aclMode: "public" | "private"`).
- **CORS Origins:** Manage authorized origins with credential allowance.
- **Document Webhooks:** Automate document delivery webhooks with secret signing, in-place PATCH updates, and delivery filter configurations.
- **Modern Architecture:** Native Terraform Plugin Framework, Protocol v6, and structured diagnostics.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Go](https://golang.org/doc/install) >= 1.22 (to build the provider plugin)

## Using the Provider

```hcl
terraform {
  required_providers {
    sanity = {
      source  = "KenzMuhammed/sanity"
      version = "~> 0.1.0"
    }
  }
}

provider "sanity" {
  # Recommended: set via SANITY_TOKEN environment variable
  # api_token = "sk..."
}
```

## Developing the Provider

### Building Locally

```bash
git clone https://github.com/KenzMuhammed/terraform-provider-sanity
cd terraform-provider-sanity
go build -v .
```

### Running Unit Tests

```bash
go test -v ./...
```

## License

This project is licensed under the [Mozilla Public License Version 2.0](LICENSE).

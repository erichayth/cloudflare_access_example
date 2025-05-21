# Cloudflare Zero Trust Access Template

This Terraform template demonstrates how to configure Cloudflare Zero Trust Access applications and policies. Use this template to quickly set up protected applications with identity-based access controls.

## Prerequisites

- Cloudflare account with Zero Trust enabled
- Terraform installed (version compatible with Cloudflare provider 4.52.0)
- Domain configured in Cloudflare

## Configuration

### Provider Configuration

Edit the `provider.tf` file to include your Cloudflare credentials:

```hcl
provider "cloudflare" {
  email = "your-email@example.com"
  api_key = "your-api-key"
}
```

### Variables

Update the required variables by creating a `terraform.tfvars` file:

```hcl
zone_id = "your-cloudflare-zone-id"
account_id = "your-cloudflare-account-id"
```

## Resources Created

### Zero Trust Access Application

The template creates an Access application with the following configuration:

- Protected domain: `lab.erichayth.com/access`
- Application type: `self_hosted`
- Session duration: 24 hours
- Identity Provider: Okta (pre-configured)
- Auto-redirect to identity provider: Enabled

Customize the application by modifying `access_application.tf`:

```hcl
resource "cloudflare_zero_trust_access_application" "demo_app" {
  zone_id             = var.zone_id
  name                = "Access Demo"
  domain              = "lab.erichayth.com/access" # Change to your domain
  type                = "self_hosted"
  session_duration    = "24h"
  allowed_idps        = ["ea943362-7e32-4167-81f5-c2d38a32ecae"] # Update with your IdP ID
  auto_redirect_to_identity = true
}
```

### Access Policy

The template configures an access policy that allows specific email addresses:

```hcl
resource "cloudflare_zero_trust_access_policy" "cf_policy" {
  application_id = cloudflare_zero_trust_access_application.demo_app.id
  account_id     = var.account_id
  name           = "Allow Access TF"
  precedence     = "1"
  decision       = "allow"

  include {
    email = ["your-email@example.com"] # Update with allowed emails
  }
}
```

Customize the policy in `access_policy.tf` to include your own email addresses or other access conditions.

## Usage

1. Clone this template to your workspace
2. Configure your credentials and variables
3. Initialize Terraform:
   ```
   terraform init
   ```
4. Plan the deployment:
   ```
   terraform plan
   ```
5. Apply the configuration:
   ```
   terraform apply
   ```

## Extending the Template

You can extend this template by:

- Adding multiple applications and policies
- Configuring additional access conditions (groups, IP ranges, etc.)
- Setting up service tokens for machine-to-machine authentication
- Implementing more advanced session controls

Refer to the [Cloudflare Terraform Provider documentation](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs) for more configuration options.

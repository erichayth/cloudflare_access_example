resource "cloudflare_zero_trust_access_application" "demo_app" {
  zone_id             = var.zone_id
  name                = "Access Demo"
  domain              = "lab.erichayth.com/access" #Public URL
  type                = "self_hosted"
  session_duration    = "24h"
  allowed_idps =["ea943362-7e32-4167-81f5-c2d38a32ecae"] #okta IdP
  auto_redirect_to_identity = true
}

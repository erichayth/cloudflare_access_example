resource "cloudflare_zero_trust_access_policy" "cf_policy" {
     application_id = cloudflare_zero_trust_access_application.demo_app.id
     account_id        = var.account_id
     name           = "Allow Access TF"
     precedence     = "1"
     decision       = "allow"

     include {
       email = ["eric@erichayth.com","eric.hayth@gmail.com"]
     }
   }

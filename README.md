# Vault OIDC Provider Setup

This module configures Vault to act as an OIDC provider and issue JWTs for authenticated users.

## Example Usage

```hcl
terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.4.0"
    }
  }
}

provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "oidc-provider-setup" {
  source  = "app.terraform.io/devops-rob/oidc-provider-setup/vault"
  version = "1.0.0"

  oidc_role_template_map = <<EOF
{ 
  "email": "{{identity.entity.metadata.email}}", 
  "username": "{{identity.entity.name}}" 
}
EOF

  oidc_role_name           = "jwt"
  oidc_key_rotation_period = 3600
  oidc_key_algorithm       = "RS256"
  oidc_issuer              = "https://identity.assetsatlas.com"
}
output "accessor_id" {
  value = module.oidc.accessor_mount_id_userpass
}

output "client_id" {
  value = module.oidc.oidc_client_id
}
```

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
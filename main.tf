resource "vault_auth_backend" "userpass" {
  type        = "userpass"
  path        = var.userpass_mount_path
  description = "Userpass auth method for user managements"
}

resource "vault_identity_oidc_key" "oidc_key" {
  name               = var.oidc_key_name
  rotation_period    = var.oidc_key_rotation_period
  algorithm          = var.oidc_key_algorithm
  verification_ttl   = var.oidc_key_verification_ttl
  allowed_client_ids = ["*"]
}

resource "vault_identity_oidc" "oidc" {
  issuer = var.oidc_issuer
}

resource "vault_policy" "jwt" {
  name   = var.oidc_role_name
  policy = <<EOF
path "/identity/oidc/token/${var.oidc_role_name}" {
  capabilities = [
    "read"
  ]
}
EOF
}

resource "vault_identity_oidc_role" "role" {
  key      = vault_identity_oidc_key.oidc_key.name
  name     = var.oidc_role_name
  template = <<EOT
{
  %{ for key, value in var.oidc_role_template_map }
  "${key}": ${value}%{ if length(var.oidc_role_template_map) > 1 && key != keys(var.oidc_role_template_map)[length(keys(var.oidc_role_template_map))-1] },%{ endif }
  %{ endfor }
}
EOT
  ttl      = var.oidc_key_rotation_period
}

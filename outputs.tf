output "accessor_mount_id_userpass" {
  value = vault_auth_backend.userpass.accessor
}

output "oidc_client_id" {
  value = vault_identity_oidc_role.role.client_id
}
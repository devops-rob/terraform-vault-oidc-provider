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

module "oidc" {
  source = "../.."
}

output "accessor_id" {
  value = module.oidc.accessor_mount_id_userpass
}

output "client_id" {
  value = module.oidc.oidc_client_id
}
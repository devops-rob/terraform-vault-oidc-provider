variable "userpass_mount_path" {
  description = "The mount path to use for the userpass auth method"
  type        = string
  default     = "userpass"
}

variable "oidc_key_name" {
  description = "The name for OIDC key that will be used to sign JWTs"
  type        = string
  default     = "my-key"
}

variable "oidc_key_rotation_period" {
  description = "Period between key rotation"
  type        = number
  default     = 3600
}

variable "oidc_key_algorithm" {
  description = "Cryptographic algorithm for OIDC key"
  type        = string
  default     = "RS256"
}

variable "oidc_key_verification_ttl" {
  description = "Verification TTL for OIDC key"
  type        = number
  default     = 7200
}

variable "oidc_role_name" {
  description = "The OIDC role name. This name will also be applied to the attached policy"
  type        = string
  default     = "jwt"
}

variable "oidc_role_template_map" {
  description = "A map of the templated claims to add to JWT"
  type        = map(any)

  default = {
    email    = "{{identity.entity.metadata.email}}"
    username = "{{identity.entity.name}}"
  }
}

variable "oidc_issuer" {
  description = "Issuer URL to be used in the iss claim of the token. If not set, Vault's api_addr will be used."
  type        = string
  default     = ""
}
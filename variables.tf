### General ###
variable "location" {
  type = string
}

variable "workload" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "public_ip_address_to_allow" {
  type = string
}

### Key Vault ###
variable "keyvault_purge_protection_enabled" {
  type = bool
}

variable "keyvault_sku_name" {
  type = string
}

variable "keyvault_key_type" {
  type = string
}

variable "keyvault_key_size" {
  type = string
}

### Virtual Machine ###
variable "vm_admin_username" {
  type = string
}

variable "vm_identity_type" {
  type = string
}

variable "vm_role_definition_name" {
  type = string
}

variable "vm_public_key_path" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_image_publisher" {
  type = string
}

variable "vm_image_offer" {
  type = string
}

variable "vm_image_sku" {
  type = string
}

variable "vm_image_version" {
  type = string
}

variable "group" {
  type = string
}

variable "location" {
  type = string
}

variable "workload" {
  type = string
}

variable "allowed_ip_addresses" {
  type = list(string)
}

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

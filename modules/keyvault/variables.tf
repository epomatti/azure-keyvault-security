variable "group" {
  type = string
}

variable "location" {
  type = string
}

variable "workload" {
  type = string
}

variable "kv_sku_name" {
  type = string
}

variable "allowed_ip_addresses" {
  type = list(string)
}

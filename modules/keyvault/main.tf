data "azurerm_client_config" "current" {}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

resource "random_string" "application_secret" {
  length  = 15
  special = true
  upper   = true
  numeric = true
}

resource "azurerm_key_vault" "default" {
  name                      = "kv-${var.workload}-${random_string.random.result}"
  location                  = var.location
  resource_group_name       = var.group
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = var.keyvault_sku_name
  enable_rbac_authorization = true

  # Must the enabled for disk encryption
  purge_protection_enabled = var.keyvault_purge_protection_enabled

  # These are only required for Azure Disk Encryption (ADE) which are not covered in this project
  enabled_for_disk_encryption = false

  # Required for CMK
  soft_delete_retention_days = 7

  # Further controlled by network_acls below
  public_network_access_enabled = true

  network_acls {
    default_action = "Deny"
    ip_rules       = var.allowed_ip_addresses
    bypass         = "AzureServices"
  }
}

resource "azurerm_role_assignment" "current" {
  scope                = azurerm_key_vault.default.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "application_secret" {
  name         = "ApplicationSecret"
  value        = random_string.application_secret.result
  key_vault_id = azurerm_key_vault.default.id

  depends_on = [azurerm_role_assignment.current]
}

resource "azurerm_key_vault_key" "application_key" {
  name         = "ApplicationKey"
  key_vault_id = azurerm_key_vault.default.id
  key_type     = var.keyvault_key_type
  key_size     = var.keyvault_key_size

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [azurerm_role_assignment.current]
}

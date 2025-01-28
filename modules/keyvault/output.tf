output "id" {
  value = azurerm_key_vault.default.id
}

output "name" {
  value = azurerm_key_vault.default.name
}

output "vault_uri" {
  value = azurerm_key_vault.default.vault_uri
}

# output "keyvault_key_id" {
#   value = azurerm_key_vault_key.generated.id
# }

# output "keyvault_key_resource_id" {
#   value = azurerm_key_vault_key.generated.resource_versionless_id
# }

output "keyvault_application_secret_id" {
  value = azurerm_key_vault_secret.application_secret.id
}

output "keyvault_application_key_id" {
  value = azurerm_key_vault_key.application_key.id
}

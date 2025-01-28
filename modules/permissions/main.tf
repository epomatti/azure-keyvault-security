resource "azurerm_role_assignment" "key_vault_vm_identity_permissions" {
  scope                = var.key_vault_id
  role_definition_name = var.vm_role_definition_name
  principal_id         = var.vm_identity_principal_id
}

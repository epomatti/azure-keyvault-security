terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.0.0"
    }
  }
}

resource "azurerm_resource_group" "default" {
  name     = "rg-${var.workload}"
  location = var.location
}

resource "azurerm_resource_group" "private_endpoints" {
  name     = "rg-${var.workload}-endpoints"
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  workload            = var.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  allowed_public_ips  = [var.public_ip_address_to_allow]
}

module "keyvault" {
  source               = "./modules/keyvault"
  workload             = var.workload
  group                = azurerm_resource_group.default.name
  location             = azurerm_resource_group.default.location
  kv_sku_name          = var.kv_sku_name
  allowed_ip_addresses = [var.public_ip_address_to_allow]
}

resource "azurerm_user_assigned_identity" "vm" {
  name                = "id-vm-${var.workload}"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
}

module "virtual_machine" {
  source                    = "./modules/vm"
  location                  = azurerm_resource_group.default.location
  resource_group_name       = azurerm_resource_group.default.name
  workload                  = var.workload
  vm_public_key_path        = var.vm_public_key_path
  vm_admin_username         = var.vm_admin_username
  vm_size                   = var.vm_size
  subnet_id                 = module.vnet.default_subnet_id
  user_assigned_identity_id = azurerm_user_assigned_identity.vm.id

  vm_image_publisher = var.vm_image_publisher
  vm_image_offer     = var.vm_image_offer
  vm_image_sku       = var.vm_image_sku
  vm_image_version   = var.vm_image_version
}

module "permissions" {
  source                   = "./modules/permissions"
  key_vault_id             = module.keyvault.id
  vm_identity_principal_id = azurerm_user_assigned_identity.vm.principal_id
  vm_role_definition_name  = var.vm_role_definition_name
}

# FIXME: 
module "privatelink_aml" {
  source                      = "./modules/private-link"
  resource_group_name         = azurerm_resource_group.private_endpoints.name
  location                    = azurerm_resource_group.default.location
  vnet_id                     = module.vnet.vnet_id
  private_endpoints_subnet_id = module.vnet.private_endpoints_subnet_id
  keyvault_id                 = module.keyvault.id
}

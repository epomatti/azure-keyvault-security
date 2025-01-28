# General
location                   = "eastus2"
workload                   = "workload"
public_ip_address_to_allow = ""
subscription_id            = ""

# Key Vault
kv_sku_name = "standard"

# Virtual Machine
vm_admin_username  = "azureuser"
vm_public_key_path = ".keys/tmp_rsa.pub"
vm_size            = "Standard_B2ls_v2"
vm_image_publisher = "canonical"
vm_image_offer     = "ubuntu-24_04-lts"
vm_image_sku       = "server"
vm_image_version   = "latest"

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
}

provider "azurerm" {
     features {}
  # Configuration options
}

# Creates a resource group
resource "azurerm_resource_group" "main" {
    name = var.rg_name
    location = "eastus"
}

# Creates a virtual network
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  vnet_name = var.vnet_name
  vnet_location = azurerm_resource_group.main.location
  use_for_each = false
  resource_group_name = azurerm_resource_group.main.name
  address_space = ["${var.net_prefix}.0.0/16"]
}

# Creates a private subnet
resource "azurerm_subnet" "main" {
  name = var.subnet1_name
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = var.vnet_name
  address_prefixes = ["${var.net_prefix}.0.0/24"]
  private_endpoint_network_policies_enabled = true
}

# Creates a network interface card (NIC)
resource "azurerm_network_interface" "internal" {
  name = var.nic_name
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Creates a virtual machine
resource "azurerm_linux_virtual_machine" "main" {
  name = var.vm_name
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  size = "Standard_F2s_v2"
  admin_username = var.vm_admin_name
  admin_password = "pswd-Enter"
  disable_password_authentication = false

    network_interface_ids = [
      azurerm_network_interface.internal.id
     ]

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = var.vm_src_img_ref.publisher
      offer = var.vm_src_img_ref.offer
      sku = var.vm_src_img_ref.sku
      version = var.vm_src_img_ref.version
    }
  } 
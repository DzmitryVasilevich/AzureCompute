variable "rg_name" {
    description = "Azure resource group name"
    type        = string
    default     = "task4-rg-eastus"  
}

variable "vnet_name" {
    description = "A virtual network name"
    type        = string
    default     = "task4-vnet-eastus"  
}

variable "net_prefix" {
    description = "A network prefix"
    type        = string
    default     = "10.0"  
}

variable "subnet1_name" {
    description = "A subnet name"
    type        = string
    default     = "task4-subnet1-eastus"  
}

variable "nic_name" {
    description = "A network interface card (NIC) name"
    type        = string
    default     = "task4-nic-int-eastus"  
}

variable "vm_name" {
    description = "A virtual machine name"
    type        = string
    default     = "task4-vm-eastus"  
}

variable "vm_src_img_ref" {
    description = "Settings for a VM source image reference"
    type        = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    default = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }   
}  
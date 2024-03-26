output "vnet_resource_id" {
    value = module.vnet.vnet_id
}

output "subnet_resource_id" {
    value = azurerm_subnet.main.id
}

output "vm_resource_id" {
    value = azurerm_windows_virtual_machine.main.id
}
locals {
  publisher = "microsoftwindowsdesktop"
  offer     = "windows-11"
  sku       = "win11-21h2-pro"
  version   = "latest"
}

resource "azurerm_windows_virtual_machine" "perf_test" {
  count = var.vm_instance_count

  name                = "${local.service_name}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.perf_test.name
  location            = azurerm_resource_group.perf_test.location

  size               = var.vm_size
  admin_username     = var.vm_user
  admin_password     = var.vm_password
  provision_vm_agent = true
  computer_name      = "${var.service_name_prefix}-${count.index + 1}"

  network_interface_ids = [
    azurerm_network_interface.perf_test[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${local.service_name}-${count.index + 1}-OsDisk"
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }

  tags = local.common_tags

}

resource "azurerm_key_vault_secret" "vm" {
  name         = "vm-password"
  value        = var.vm_password
  key_vault_id = azurerm_key_vault.perf_test.id
}
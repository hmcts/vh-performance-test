locals {
  publisher = "microsoftwindowsdesktop"
  offer     = "windows-11"
  sku       = "win11-21h2-pro"
  version   = "latest"
}

resource "azurerm_windows_virtual_machine" "perf_test" {
  count = var.vm_instance_count

  name                = "${var.service_name}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.perf_test.name
  location            = azurerm_resource_group.perf_test.location

  size               = var.vm_size
  admin_username     = "" #AKV
  admin_password     = "" #AKV
  provision_vm_agent = true

  network_interface_ids = [
    azurerm_network_interface.perf_test[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.service_name}-${count.index + 1}-OsDisk"
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }

  tags = local.common_tags

}
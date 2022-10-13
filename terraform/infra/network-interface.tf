
resource "azurerm_network_interface" "perf_test" {
  count = var.vm_instance_count

  name = "${local.service_name}_${count.index + 1}"

  resource_group_name = azurerm_resource_group.perf_test.name
  location            = azurerm_resource_group.perf_test.location

  ip_configuration {
    name                          = "perf_testConfiguration"
    subnet_id                     = azurerm_subnet.perf_test.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "perf_test" {
  count = var.vm_instance_count

  network_interface_id      = azurerm_network_interface.perf_test[count.index].id
  network_security_group_id = azurerm_network_security_group.perf_test.id
}

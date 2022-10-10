
resource "azurerm_virtual_network" "perf_test" {
  name          = var.service_name
  address_space = [var.address_space]

  resource_group_name = azurerm_resource_group.perf_test.name
  location            = azurerm_resource_group.perf_test.location
  tags                = local.common_tags
}

resource "azurerm_subnet" "perf_test" {
  name                 = "perf-test"
  resource_group_name  = azurerm_resource_group.perf_test.name
  virtual_network_name = azurerm_virtual_network.perf_test.name
  address_prefixes     = [var.address_space]

  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet_network_security_group_association" "perf_test" {
  subnet_id                 = azurerm_subnet.wowzperf_testa.id
  network_security_group_id = azurerm_network_security_group.perf_test.id
}

resource "azurerm_network_security_group" "perf_test" {
  name = var.service_name

  resource_group_name = azurerm_resource_group.perf_test.name
  location            = azurerm_resource_group.perf_test.location

  security_rule {
    name                       = "allow-rdp"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    destination_address_prefix = "*"
  }

  tags = local.common_tags

}
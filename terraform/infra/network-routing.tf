resource "azurerm_route_table" "perf_test" {
  name                          = local.service_name
  location                      = azurerm_resource_group.perf_test.location
  resource_group_name           = azurerm_resource_group.perf_test.name
  disable_bgp_route_propagation = false

  tags = local.common_tags

  dynamic "route" {
    for_each = var.route_table
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}

resource "azurerm_subnet_route_table_association" "perf_test" {
  subnet_id      = azurerm_subnet.perf_test.id
  route_table_id = azurerm_route_table.perf_test.id
}
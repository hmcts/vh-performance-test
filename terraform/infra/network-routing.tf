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

# data "azurerm_route_table" "aks_appgw_route_table" {
#   count               = var.env == "stg" ? 1 : 0
#   name                = "aks-${var.environment}-appgw-route-table"
#   resource_group_name = "ss-${var.environment}-network-rg"
# }

# resource "azurerm_route" "vh_perf_test" {
#   count                  = var.env == "stg" ? 1 : 0
#   name                   = local.service_name
#   resource_group_name    = data.azurerm_route_table.aks_appgw_route_table[0].resource_group_name
#   route_table_name       = data.azurerm_route_table.aks_appgw_route_table[0].name
#   address_prefix         = element(var.address_space, 0)
#   next_hop_type          = "VirtualAppliance"
#   next_hop_in_ip_address = "10.11.8.36"
# }

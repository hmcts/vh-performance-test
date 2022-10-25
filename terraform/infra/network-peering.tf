
resource "azurerm_virtual_network_peering" "vnet_to_vpn_hub" {
  provider = azurerm.peering_client
  for_each = toset(local.peering_vpn_vnets)

  name                      = each.value
  resource_group_name       = azurerm_resource_group.perf_test.name
  virtual_network_name      = azurerm_virtual_network.perf_test.name
  remote_virtual_network_id = "/subscriptions/${local.peering_vpn_subscription}/resourceGroups/${local.peering_vpn_resourcegroup}/providers/Microsoft.Network/virtualNetworks/${each.value}"
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "vpn_hub_to_vnet" {
  provider = azurerm.peering_target_vpn
  for_each = toset(local.peering_vpn_vnets)

  name                      = azurerm_virtual_network.perf_test.name
  resource_group_name       = local.peering_vpn_resourcegroup
  virtual_network_name      = each.value
  remote_virtual_network_id = azurerm_virtual_network.perf_test.id
  allow_forwarded_traffic   = true
}

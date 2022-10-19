locals {
  peering_nonprod_vnets        = var.environment != "prod" && var.environment != "stg" ? ["hmcts-hub-nonprodi"] : []
  peering_nonprod_subscription = "fb084706-583f-4c9a-bdab-949aac66ba5c"
}

resource "azurerm_virtual_network_peering" "vnet_to_uks_nonprod_hub" {
  provider = azurerm.peering_client
  for_each = toset(local.peering_nonprod_vnets)

  name                      = each.value
  resource_group_name       = azurerm_resource_group.perf_test.name
  virtual_network_name      = azurerm_virtual_network.perf_test.name
  remote_virtual_network_id = "/subscriptions/${local.peering_nonprod_subscription}/resourceGroups/${each.value}/providers/Microsoft.Network/virtualNetworks/${each.value}"
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "vpn_hub_to_vnet" {
  provider = azurerm.peering_target_vpn
  for_each = toset(local.peering_vpn_vnets)

  name                      = azurerm_virtual_network.wowza.name
  resource_group_name       = local.peering_vpn_resourcegroup
  virtual_network_name      = each.value
  remote_virtual_network_id = azurerm_virtual_network.wowza.id
  allow_forwarded_traffic   = true
}
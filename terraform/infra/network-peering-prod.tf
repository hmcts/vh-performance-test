locals {
  peering_prod_vnets        = var.environment == "prod" || var.environment == "stg" ? ["hmcts-hub-prod-int", "ukw-hub-prod-int"] : []
  peering_prod_subscription = "0978315c-75fe-4ada-9d11-1eb5e0e0b214"
}

resource "azurerm_virtual_network_peering" "vnet_to_uks_prod_hub" {
  for_each                  = toset(local.peering_prod_vnets)
  name                      = each.value
  resource_group_name       = azurerm_resource_group.perf_test.name
  virtual_network_name      = azurerm_virtual_network.perf_test.name
  remote_virtual_network_id = "/subscriptions/${local.peering_prod_subscription}/resourceGroups/${each.value}/providers/Microsoft.Network/virtualNetworks/${each.value}"
  allow_forwarded_traffic   = true
}

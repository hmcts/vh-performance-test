locals {
  domain_env            = var.environment == "stg" ? "staging." : "${var.environment}."
  private_dns_zone      = "${local.domain_env}platform.hmcts.net"
  private_dns_zone_rg   = "core-infra-intsvc-rg"
}

data "azurerm_private_dns_zone" "perf_test" {
  provider = azurerm.private-endpoint-dns

  name                = local.private_dns_zone
  resource_group_name = local.private_dns_zone_rg
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  provider = azurerm.private-endpoint-dns

  name                  = "${azurerm_virtual_network.perf_test.name}-link"
  resource_group_name   = local.private_dns_zone_rg
  private_dns_zone_name = data.azurerm_private_dns_zone.perf_test.name
  virtual_network_id    = azurerm_virtual_network.perf_test.id
  registration_enabled  = false

  tags = var.tags
}
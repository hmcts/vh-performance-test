
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "perf_test" {
  name                = "perf_test_keyvault"
  location            = azurerm_resource_group.perf_test.location
  resource_group_name = azurerm_resource_group.perf_test.name

  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  tags = local.common_tags

}
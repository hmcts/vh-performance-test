resource "azurerm_automation_account" "vm-start-stop" {

  name                = "vh-perf-test-${var.environment}-aa"
  location            = azurerm_resource_group.perf_test.location
  resource_group_name = azurerm_resource_group.perf_test.name
  sku_name            = "Basic"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.perf_test_automation_account_mi.id]
  }

  tags = local.common_tags
}

module "vm_automation" {
  source = "git::https://github.com/hmcts/cnp-module-automation-runbook-start-stop-vm?ref=adding-days"

  product                 = "vh-perf-test"
  env                     = var.environment
  location                = azurerm_resource_group.perf_test.location
  automation_account_name = azurerm_automation_account.vm-start-stop.name
  tags                    = local.common_tags
  schedules               = var.schedules
  resource_group_name     = azurerm_resource_group.perf_test.name
  vm_names                = var.vm_names_for_automation
  mi_principal_id         = azurerm_user_assigned_identity.perf_test_automation_account_mi.principal_id
}

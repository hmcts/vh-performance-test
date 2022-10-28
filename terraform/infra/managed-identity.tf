resource "azurerm_user_assigned_identity" "perf_test_automation_account_mi" {
  resource_group_name = azurerm_resource_group.perf_test.name
  location            = azurerm_resource_group.perf_test.location

  name = "perf_test-automation-mi-${var.environment}"

  tags = local.common_tags

}


resource "azurerm_role_definition" "virtual_machine_control" {
  name        = "Virtual-Machine-Control-${var.environment}"
  scope       = azurerm_resource_group.perf_test.id
  description = "Custom Role for controlling virtual machines"
  permissions {
    actions = [
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Compute/virtualMachines/start/action",
      "Microsoft.Compute/virtualMachines/deallocate/action",
    ]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_resource_group.perf_test.id,
  ]

}

resource "azurerm_role_assignment" "perf_test_auto_acct_mi_role" {
  scope = azurerm_resource_group.perf_test.id


  role_definition_id = azurerm_role_definition.virtual_machine_control.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.perf_test_automation_account_mi.principal_id

  depends_on = [
    azurerm_role_definition.virtual_machine_control
  ]

}
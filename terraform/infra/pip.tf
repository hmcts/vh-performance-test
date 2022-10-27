resource "azurerm_public_ip" "perf_test" {
  count = var.vm_instance_count

  name                = "devPip-${count.index + 1}"
  resource_group_name = azurerm_resource_group.perf_test.name
  location            = azurerm_resource_group.perf_test.location
  allocation_method   = "Static"
  domain_name_label   = "hmcts-vh-perf-${count.index + 1}"

  tags = local.common_tags
}
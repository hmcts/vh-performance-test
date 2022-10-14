#### LOCALS

locals {
  # Main
  common_tags  = module.ctags.common_tags
  service_name = "${var.service_name_prefix}-${var.environment}"
  # Networking - VPN
  peering_vpn_vnets         = ["core-infra-vnet-mgmt"]
  peering_vpn_subscription  = "ed302caf-ec27-4c64-a05e-85731c3ce90e"
  peering_vpn_resourcegroup = "rg-mgmt"
}

# Set up common tagss
module "ctags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.environment
  product     = var.product
  builtFrom   = var.builtFrom
}

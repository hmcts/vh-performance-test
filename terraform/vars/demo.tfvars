
location          = "UK South"
address_space     = ["10.50.10.80/28"]
vm_size           = "Standard_D8_v5" //Current exemption for this SKU. Should be "Standard_D8ds_v5"
vm_instance_count = 2

route_table = [
  {
    name                   = "ss_demo_aks"
    address_prefix         = "10.51.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

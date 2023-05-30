
location          = "UK South"
address_space     = ["10.24.0.112/28"]
vm_size           = "Standard_D8_v5"
vm_instance_count = 2

route_table = [
    {
    name                   = "ss_test_aks"
    address_prefix         = "10.141.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]
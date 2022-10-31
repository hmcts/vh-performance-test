
location          = "UK South"
address_space     = ["10.50.10.96/28"]
vm_size           = "Standard_D8_v5"
vm_instance_count = 2

schedules = [
  {
    name      = "vm-on",
    frequency = "Day"
    interval  = 1
    run_time  = "07:00:00"
    start_vm  = true
  },
  {
    name      = "vm-off",
    frequency = "Day"
    interval  = 1
    run_time  = "19:00:00"
    start_vm  = false
  }
]

route_table = [
  {
    name                   = "ss_dev_aks"
    address_prefix         = "AKS"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]
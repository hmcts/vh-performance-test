
variable "service_name_prefix" {
  type        = string
  default     = "vh-perf-test"
  description = "The name of the service"
}

variable "location" {
  type        = string
  default     = "UK South"
  description = "Location of the resorces"
}

variable "environment" {
  type = string
}

variable "product" {
  type = string
}

variable "project" {
  type = string
}

variable "builtFrom" {
  type = string
}

variable "address_space" {
  type = list(any)
}

# VM Stuff
variable "vm_size" {
  type    = string
  default = ""
}

variable "vm_instance_count" {
  type    = number
  default = 1
}

variable "vm_user" {
  type = string
}

variable "vm_password" {
  type = string
}


variable "schedules" {
  type = list(object({
    name      = string
    frequency = string
    interval  = number
    run_time  = string
    start_vm  = bool
  }))
  default     = []
  description = "List of Schedules to trigger the VM turn on and/or off."

variable "route_table" {
  description = "Route Table routes"

}

# Networking Client Details
variable "network_client_id" {
  description = "Client ID of the GlobalNetworkPeering SP"
  type        = string
}
variable "network_client_secret" {
  description = "Client Secret of the GlobalNetworkPeering SP"
  type        = string
  sensitive   = true
}
variable "network_tenant_id" {
  description = "Client Tenant ID of the GlobalNetworkPeering SP"
  type        = string
}


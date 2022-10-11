
variable "service_name" {
  type        = string
  default     = "pref-test"
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


# Need to update the following
variable "workspace_to_address_space_map" {
  type = map(string)
  default = {
    prod = "10.50.11.16/28"
    stg  = "10.50.10.112/28"
    dev  = "10.100.198.64/28"
    demo = "10.254.0.224/28"
    test = "10.100.197.208/28"
    sbox = "10.100.198.32/28"
    ithc = "10.100.197.224/28"
  }
}

#### LOCALS

locals {
  common_tags = module.ctags.common_tags
}

module "ctags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.environment
  product     = var.product
  builtFrom   = var.builtFrom
}

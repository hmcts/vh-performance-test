
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

#### LOCALS

locals {
  common_tags = module.ctags.common_tags
  service_name = "${var.service_name_prefix}-${var.environment}"
}

module "ctags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.environment
  product     = var.product
  builtFrom   = var.builtFrom
}

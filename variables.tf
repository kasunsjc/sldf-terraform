#--root/variables.tf
variable "rg_name" {
  default = "rg-sldf-demo"
}

variable "location" {
  default = "southeastasia"
}

variable "vnet_cidr" {
  default = "10.100.0.0/16"
}

variable "vnet_name" {
  default = "sldf-vnet-dev"
}

variable "web_subnet_name" {
  default = "web"
}

variable "business_subnet_name" {
  default = "buisness"
}

variable "vm_count" {
  default = "2"
}

variable "web_vm_name" {
  default = "web"
}

variable "vm_size" {
  default = "standard_b2s"
}

variable "tenent_id" {}
variable "sub_id" {}
variable "spn_secret" {}
variable "spn_app_id" {}

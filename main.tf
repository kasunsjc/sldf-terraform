#--root/main.tf

module "shared" {
  source = "./shared"
  rg_name = "${local.rg_prefix}-${var.rg_name}-${local.sufix}"
  location = var.location
}

module "networking" {
  source = "./networking"
  vnet_cidr = var.vnet_cidr
  location = var.location
  rg_name = module.shared.rg_name
  vnet_name = "${local.prefix}-${var.vnet_name}-${local.sufix}"
  web_subnet_name = var.web_subnet_name
  business_subnet_name = var.business_subnet_name
  web_subnet_prefix = local.web_subnet_prefix
  business_subnet_prefix = local.business_subnet_prefix
  web_nsg_name = "${local.prefix}-web-nsg-${local.sufix}"
  business_nsg_name = "${local.prefix}-business-nsg-${local.sufix}"
  web_nsg_rules = local.webnsgrules
  business_nsg_rules = local.buisnessnsgrules
}

module "compute" {
  source = "./compute"
  web_subnet_id = module.networking.web_subnet_id
  location = var.location
  rg_name = module.shared.rg_name
  vm_count = var.vm_count
  web_vm_name = var.web_vm_name
  vm_size = var.vm_size
}
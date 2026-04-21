variable "group_number" {
  type        = string
  description = "Group Number from Brightspace"
  default     = "6"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "canadacentral"
}

module "network" {
  source       = "./modules/network"
  group_number = var.group_number
  location     = var.location
}

module "remix_app" {
  source              = "./modules/remix_app"
  group_number        = var.group_number
  location            = var.location
  resource_group_name = module.network.resource_group_name
  subnet_test_id      = module.network.subnet_test_id
  subnet_prod_id      = module.network.subnet_prod_id
}

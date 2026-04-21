variable "group_number" {
  description = "Group number from Brightspace"
  type        = string
  default     = "00"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

resource "azurerm_resource_group" "tfstate" {
  name     = "cst8918-tfstate-group-${var.group_number}"
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${var.group_number}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

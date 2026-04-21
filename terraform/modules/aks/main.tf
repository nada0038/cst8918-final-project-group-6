#tfsec:ignore:azure-container-use-rbac-permissions
#tfsec:ignore:azure-container-limit-authorized-ips
#tfsec:ignore:azure-container-configured-network-policy
#tfsec:ignore:azure-container-logging
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.env}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.env}-dns"
  kubernetes_version  = "1.32"

  default_node_pool {
    name           = "default"
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id

    enable_auto_scaling = var.max_count > var.min_count ? true : false
    node_count          = var.node_count
    min_count           = var.max_count > var.min_count ? var.min_count : null
    max_count           = var.max_count > var.min_count ? var.max_count : null
  }

  identity {
    type = "SystemAssigned"
  }
}

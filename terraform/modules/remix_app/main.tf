resource "azurerm_container_registry" "acr" {
  name                = "acrremix${var.group_number}${random_string.acr_suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "random_string" "acr_suffix" {
  length  = 6
  special = false
  upper   = false
}

module "aks_test" {
  source              = "../aks"
  env                 = "test"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_test_id
  node_count          = 1
  min_count           = 1
  max_count           = 1
  vm_size             = "Standard_B2s"
}

module "aks_prod" {
  source              = "../aks"
  env                 = "prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_prod_id
  node_count          = 1
  min_count           = 1
  max_count           = 3
  vm_size             = "Standard_B2s"
}

resource "azurerm_redis_cache" "redis_test" {
  name                = "redis-test-${var.group_number}-${random_string.acr_suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
}

resource "azurerm_redis_cache" "redis_prod" {
  name                = "redis-prod-${var.group_number}-${random_string.acr_suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
}

# Provide ACR pull access to test and prod AKS
resource "azurerm_role_assignment" "aks_test_acr" {
  principal_id                     = module.aks_test.kubelet_identity_object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "aks_prod_acr" {
  principal_id                     = module.aks_prod.kubelet_identity_object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

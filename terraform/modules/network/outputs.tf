output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Name of the main resource group"
}

output "resource_group_location" {
  value       = azurerm_resource_group.main.location
  description = "Location of the main resource group"
}

output "subnet_test_id" {
  value       = azurerm_subnet.test.id
  description = "ID of the test subnet"
}

output "subnet_prod_id" {
  value       = azurerm_subnet.prod.id
  description = "ID of the prod subnet"
}

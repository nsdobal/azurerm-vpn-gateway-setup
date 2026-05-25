resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  managed_by = var.managed_by

  tags = var.environment == null ? var.tags : merge({environment = var.environment},var.tags)
}
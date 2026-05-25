resource "azurerm_public_ip" "pip" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku != null ? var.sku : null
  sku_tier            = var.sku_tier
  zones               = var.zones != null ? var.zones : null

  tags = merge({ environment = var.environment }, var.tags)
}
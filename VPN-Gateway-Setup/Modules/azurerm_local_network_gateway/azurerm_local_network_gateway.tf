resource "azurerm_local_network_gateway" "Local_Network_Gateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  address_space = var.address_space == null ? null : var.address_space

  gateway_address = var.gateway_address == null ? null : var.gateway_address
  gateway_fqdn    = var.gateway_fqdn == null ? null : var.gateway_fqdn

  dynamic "bgp_settings" {
    for_each = var.bgp_settings == null ? [] : [var.bgp_settings]

    content {
      asn                 = bgp_settings.value.asn
      bgp_peering_address = bgp_settings.value.bgp_peering_address
      peer_weight         = bgp_settings.value.peer_weight == null ? null : var.bgp_settings.value.peer_weight
    }
  }

  tags = merge({ "environment" = var.environment }, var.tags)
}

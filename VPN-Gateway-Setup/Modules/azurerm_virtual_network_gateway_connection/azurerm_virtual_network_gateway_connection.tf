resource "azurerm_virtual_network_gateway_connection" "VNET_Gateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  type                       = var.type #IPsec, ExpressRoute, Vnet2Vnet
  virtual_network_gateway_id = var.virtual_network_gateway_id

  #optional
  authorization_key               = var.authorization_key == null ? null : var.authorization_key
  dpd_timeout_seconds             = var.dpd_timeout_seconds == null ? null : var.dpd_timeout_seconds
  express_route_circuit_id        = var.express_route_circuit_id == null ? null : var.express_route_circuit_id
  peer_virtual_network_gateway_id = var.peer_virtual_network_gateway_id == null ? null : var.peer_virtual_network_gateway_id #For vnet2vnet peering
  local_azure_ip_address_enabled  = var.local_azure_ip_address_enabled == null ? null : var.local_azure_ip_address_enabled
  local_network_gateway_id        = var.local_network_gateway_id == null ? null : var.local_network_gateway_id #For Site2Site connection, type is IPsec
  routing_weight                  = var.routing_weight                                                         #Default=10
  shared_key                      = var.shared_key == null ? null : var.shared_key
  connection_mode                 = var.connection_mode                                              #(Default, InitiatorOnly, ResponderOnly), Default = Default 
  connection_protocol             = var.connection_protocol == null ? null : var.connection_protocol #(IKEv1, IKEv2) , null
  bgp_enabled                     = var.bgp_enabled                                                  #bool, default=false
  dynamic "custom_bgp_addresses" {
    for_each = var.custom_bgp_addresses == null ? [] : [var.custom_bgp_addresses]
    content {
      primary   = custom_bgp_addresses.value.primary
      secondary = custom_bgp_addresses.value.secondary
    }
  }
  express_route_gateway_bypass       = var.express_route_gateway_bypass == null ? null : var.express_route_gateway_bypass #For expressroute, default = null
  private_link_fast_path_enabled     = var.private_link_fast_path_enabled                                                 #default = false
  egress_nat_rule_ids                = var.egress_nat_rule_ids == null ? null : var.egress_nat_rule_ids                   #list of string
  ingress_nat_rule_ids               = var.ingress_nat_rule_ids == null ? null : var.ingress_nat_rule_ids                 #list of string
  use_policy_based_traffic_selectors = var.use_policy_based_traffic_selectors                                             #default = false

  dynamic "ipsec_policy" {
    for_each = var.ipsec_policy == null ? [] : [var.ipsec_policy]

    content {
      dh_group         = ipsec_policy.value.dh_group
      ike_encryption   = ipsec_policy.value.ike_encryption
      ike_integrity    = ipsec_policy.value.ike_integrity
      ipsec_encryption = ipsec_policy.value.ipsec_encryption
      ipsec_integrity  = ipsec_policy.value.ipsec_integrity
      pfs_group        = ipsec_policy.value.pfs_group
      sa_datasize      = ipsec_policy.value.sa_datasize
      sa_lifetime      = ipsec_policy.value.sa_lifetime
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = var.traffic_selector_policy == null ? [] : [var.traffic_selector_policy]

    content {
      local_address_cidrs  = traffic_selector_policy.value.local_address_cidrs
      remote_address_cidrs = traffic_selector_policy.value.remote_address_cidrs
    }
  }
}
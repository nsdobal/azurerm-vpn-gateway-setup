#### RG ####

module "azurerm_resource_group" {
  source = "../../Modules/azurerm_resource_group"

  for_each    = var.rg
  name        = each.key
  location    = each.value.location
  environment = each.value.environment
  tags        = each.value.tags
}

#### VNET ####

module "azurerm_virtual_network" {
  source     = "../../Modules/azurerm_virtual_network"
  depends_on = [module.azurerm_resource_group]

  for_each = var.vnets

  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  environment         = each.value.environment
  tags                = each.value.tags
}

#### SUBNET ####

module "azurerm_subnet" {
  source     = "../../Modules/azurerm_subnet"
  depends_on = [module.azurerm_resource_group, module.azurerm_virtual_network]

  for_each = var.subnets

  name                 = each.key
  resource_group_name  = module.azurerm_resource_group[each.value.resource_group_name].rg-name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
}

#### PIP ####

module "azurerm_public_ip" {
  source     = "../../Modules/azurerm_public_ip"
  depends_on = [module.azurerm_resource_group]

  for_each            = var.pip
  name                = each.key
  resource_group_name = module.azurerm_resource_group[each.value.resource_group_name].rg-name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  sku_tier            = each.value.sku_tier
  zones               = each.value.zones
  environment         = each.value.environment
  tags                = each.value.tags
}

#### VPN Gateway ####

module "azurerm_virtual_network_gateway" {
  source     = "../../Modules/azurerm_virtual_network_gateway"
  depends_on = [module.azurerm_resource_group, module.azurerm_public_ip, module.azurerm_virtual_network, module.azurerm_subnet]

  for_each                   = var.vpn-gateway
  name                       = each.key
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  sku                        = each.value.sku
  type                       = each.value.type
  vpn_type                   = each.value.vpn_type
  private_ip_address_enabled = each.value.private_ip_address_enabled

  ip_configuration = {
    subnet_id            = module.azurerm_subnet[each.value.ip_configuration.subnet_name].id
    public_ip_address_id = module.azurerm_public_ip[each.value.ip_configuration.public_ip_address].id
  }
  vpn_client_configuration = {
    address_space = each.value.vpn_client_configuration.address_space
  }

  # virtual_network_gateway_client_connection = each.value.virtual_network_gateway_client_connection
}

#### Local_Network_Gateway ####

module "azurerm_local_network_gateway" {
  source     = "../../Modules/azurerm_local_network_gateway"
  depends_on = [module.azurerm_resource_group, module.azurerm_public_ip, module.azurerm_virtual_network, module.azurerm_subnet]

  for_each            = var.Local_Network_Gateway
  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  gateway_address     = each.value.gateway_address
  address_space       = each.value.address_space
  gateway_fqdn        = each.value.gateway_fqdn
  environment         = each.value.environment
  tags                = each.value.tags

}

#### VNET_Gateway_Connection ####

module "azurerm_virtual_network_gateway_connection" {
  source     = "../../Modules/azurerm_virtual_network_gateway_connection"
  depends_on = [module.azurerm_resource_group, module.azurerm_virtual_network, module.azurerm_subnet, module.azurerm_local_network_gateway, module.azurerm_virtual_network_gateway]

  for_each                   = var.VNET_Gateway_Connection
  name                       = each.key
  resource_group_name        = each.value.resource_group_name
  location                   = each.value.location
  type                       = each.value.type
  virtual_network_gateway_id = module.azurerm_virtual_network_gateway[each.value.virtual_network_gateway].id

  authorization_key                  = each.value.authorization_key
  dpd_timeout_seconds                = each.value.dpd_timeout_seconds
  express_route_circuit_id           = each.value.express_route_circuit_id
  peer_virtual_network_gateway_id    = each.value.peer_virtual_network_gateway_id
  local_azure_ip_address_enabled     = each.value.local_azure_ip_address_enabled
  local_network_gateway_id           = module.azurerm_local_network_gateway[each.value.local_network_gateway].id
  routing_weight                     = each.value.routing_weight
  shared_key                         = each.value.shared_key
  connection_mode                    = each.value.connection_mode
  connection_protocol                = each.value.connection_protocol
  bgp_enabled                        = each.value.bgp_enabled
  express_route_gateway_bypass       = each.value.express_route_gateway_bypass
  private_link_fast_path_enabled     = each.value.private_link_fast_path_enabled
  egress_nat_rule_ids                = each.value.egress_nat_rule_ids
  ingress_nat_rule_ids               = each.value.ingress_nat_rule_ids
  use_policy_based_traffic_selectors = each.value.use_policy_based_traffic_selectors
  custom_bgp_addresses               = each.value.custom_bgp_addresses
  ipsec_policy                       = each.value.ipsec_policy
  traffic_selector_policy            = each.value.traffic_selector_policy

}

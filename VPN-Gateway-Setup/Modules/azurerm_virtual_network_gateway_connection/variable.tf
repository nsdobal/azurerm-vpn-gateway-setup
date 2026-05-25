variable "name" {
  type = string
  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty for azurerm_virtual_network_gateway_connection"
  }
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "type" {
  type = string #valid values: Ipsec, ExpressRoute, Vnet2Vnet
}

variable "virtual_network_gateway_id" {
  type = string
}

variable "authorization_key" {
  type     = string
  nullable = true
  default  = null
}

variable "dpd_timeout_seconds" {
  type     = string
  nullable = true
  default  = null
}

variable "express_route_circuit_id" {
  type     = string
  nullable = true
  default  = null
}

variable "peer_virtual_network_gateway_id" {
  type     = string
  nullable = true
  default  = null
}

variable "local_azure_ip_address_enabled" {
  type     = bool
  nullable = true
  default  = null
}

variable "local_network_gateway_id" {
  type     = string
  nullable = true
  default  = null
}

variable "routing_weight" {
  type    = number
  default = 10
}

variable "shared_key" {
  type     = string
  nullable = true
  default  = null
}

variable "connection_mode" {
  type    = string
  default = "Default"
}

variable "connection_protocol" {
  type     = string
  nullable = true
  default  = null
}

variable "bgp_enabled" {
  type    = bool
  default = false
}

variable "express_route_gateway_bypass" {
  type     = string
  nullable = true
  default  = null
}

variable "private_link_fast_path_enabled" {
  type    = bool
  default = false
}

variable "egress_nat_rule_ids" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "ingress_nat_rule_ids" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "use_policy_based_traffic_selectors" {
  type    = bool
  default = false
}

variable "custom_bgp_addresses" {
  type = object({
    primary   = string
    secondary = optional(string, null)
  })
  nullable = true
  default  = null
}

variable "ipsec_policy" {
  type = object({
    dh_group         = string
    ike_encryption   = string
    ike_integrity    = string
    ipsec_encryption = string
    ipsec_integrity  = string
    pfs_group        = string
    sa_datasize      = string
    sa_lifetime      = string
  })
}

variable "traffic_selector_policy" {
  type = object({
    local_address_cidrs  = string
    remote_address_cidrs = string
  })
  nullable = true
  default  = null
}
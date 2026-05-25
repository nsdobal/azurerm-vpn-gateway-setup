#### RG ####

variable "rg" {
  type = map(object({
    name        = optional(string)
    location    = string
    environment = optional(string, "dev")
    tags        = optional(map(string), {})
  }))
}

#### VNET ####

variable "vnets" {
  type = map(object({
    name                = optional(string)
    resource_group_name = string
    location            = string
    address_space       = list(string)
    dns_servers         = optional(list(string))
    environment         = optional(string, "dev")
    tags                = optional(map(string), {})
  }))
}


#### SUBNET ####

variable "subnets" {
  type = map(object({
    name                 = optional(string)
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string), [])
  }))
}

#### PIP ####

variable "pip" {
  type = map(object({
    name                = optional(string)
    resource_group_name = string
    location            = string
    allocation_method   = optional(string, "Static")
    sku                 = optional(string, "Standard")
    sku_tier            = optional(string, "Regional")
    zones               = optional(list(string), ["1", "2"])
    environment         = optional(string, "dev")
    tags                = optional(map(string), {})
  }))
}

#### VPN Gateway #### 

variable "vpn-gateway" {
  type = map(object({
    name                       = optional(string)
    location                   = string
    resource_group_name        = string
    sku                        = optional(string, "VpnGw1")
    type                       = optional(string, "Vpn")
    vpn_type                   = optional(string, "RouteBased")
    private_ip_address_enabled = optional(bool, true)
    ip_configuration = optional(object({
      subnet_name       = string
      public_ip_address = optional(string)
    }))

    vpn_client_configuration = optional(object({
      address_space = optional(list(string), null)
      })
    , null)

  }))
}

#### Local_Network_Gateway ####

variable "Local_Network_Gateway" {
  type = map(object({
    name                = optional(string)
    resource_group_name = string
    location            = string
    gateway_address     = optional(string)
    address_space       = optional(list(string))
    gateway_fqdn        = optional(string)
    environment         = optional(string, "Dev")
    tags                = optional(map(string), {})
    bgp_settings = optional(object({
      asn                 = string
      bgp_peering_address = string
      peer_weight         = optional(number, 10)
    }))
  }))
}

#### VNET_Gateway_Connection ####

variable "VNET_Gateway_Connection" {
  type = map(object({
    name                = optional(string)
    resource_group_name = string
    location            = string

    type                               = optional(string, "IPsec")
    virtual_network_gateway            = string
    authorization_key                  = optional(string)
    dpd_timeout_seconds                = optional(string)
    express_route_circuit_id           = optional(string)
    peer_virtual_network_gateway_id    = optional(string)
    local_azure_ip_address_enabled     = optional(bool, true)
    local_network_gateway              = optional(string)
    routing_weight                     = optional(number, 10)
    shared_key                         = optional(string)
    connection_mode                    = optional(string, "Default")
    connection_protocol                = optional(string)
    bgp_enabled                        = optional(bool, false)
    express_route_gateway_bypass       = optional(string)
    private_link_fast_path_enabled     = optional(bool, false)
    egress_nat_rule_ids                = optional(list(string))
    ingress_nat_rule_ids               = optional(list(string))
    use_policy_based_traffic_selectors = optional(bool, false)

    custom_bgp_addresses = optional(object({
      primary   = string
      secondary = optional(string)
    }))

    ipsec_policy = optional(object({
      dh_group         = string
      ike_encryption   = string
      ike_integrity    = string
      ipsec_encryption = string
      ipsec_integrity  = string
      pfs_group        = string
      sa_datasize      = string
      sa_lifetime      = string
    }))

    traffic_selector_policy = optional(object({
      local_address_cidrs  = string
      remote_address_cidrs = string
    }))

  }))
}


#### NSG ####

# variable "nsg" {
#   type = map(object({
#     name                = string
#     resource_group_name = string
#     location            = string
#     environment         = string
#     tags                = optional(map(string), {})
#   }))
# }

# #### NSG RULES ####

# variable "rules" {
#   type = map(object({
#     name                        = string
#     resource_group_name         = string
#     network_security_group_name = string
#     priority                    = number
#     direction                   = string
#     access                      = string
#     protocol                    = string
#     source_port_range           = string
#     destination_port_ranges     = list(string)
#     source_address_prefix       = string
#     destination_address_prefix  = string
#   }))
# }

# #### NSG Attach ####

# variable "nsg-attach" {
#   type = map(object({
#     subnet                 = string
#     network_security_group = string
#   }))
# }

# #### Linux VM ####

# variable "Linux-VMs" {
#   type = map(object({
#     name                = string
#     location            = string
#     resource_group_name = string

#     vnet   = optional(string, "")
#     subnet = string
#     # network_interface_ids = list(string)
#     enable_pip = optional(bool, false)
#     pip        = optional(string)
#     nsg        = optional(string, "")

#     size = string

#     os_disk = object({
#       storage_account_type = optional(string, "Standard_LRS")
#     })
#     storage_account_type = optional(string, "Standard_LRS")

#     source_image_reference = object({
#       publisher = optional(string, "Canonical")
#       offer     = optional(string, "0001-com-ubuntu-server-jammy")
#       sku       = optional(string, "22_04-lts")
#       version   = optional(string, "latest")
#     })

#     admin_username = optional(string, "azure")
#     admin_password = optional(string, "Welcome@12345")
#     environment    = string
#     tags           = optional(map(string), {})
#   }))
# }


# #### Bastion ####

# variable "bastion" {
#   type = map(object({
#     name                = string
#     location            = string
#     resource_group_name = string
#     vnet                = string
#     sku                 = optional(string, "Basic")
#     ip_configuration = object({
#       name   = string
#       subnet = string
#       pip    = string
#     })
#     tags = optional(map(string), {})
#   }))
# }


# #### Windows VM ####

# variable "vms" {
#   type = map(object({
#     name                = string
#     location            = optional(string)
#     resource_group_name = optional(string)
#     enable_pip          = optional(bool)

#     subnet            = string
#     public_ip_address = optional(string)

#     vm_size = string
#     # license_type                  = optional(string)

#     admin_username = optional(string)
#     admin_password = optional(string)

#     # storage_os_disk = optional (object({
#     #   name          = optional(string)
#     #   create_option = optional(string)
#     #   caching       = optional(string)
#     #   disk_size_gb  = optional(string)
#     #   os_type       = optional(string)
#     # }))

#     storage_image_reference = optional(object({
#       publisher = optional(string)
#       offer     = optional(string)
#       sku       = optional(string)
#       version   = optional(string)
#     }))

#     environment = optional(string)
#     tags        = optional(map(string))
#   }))
# }


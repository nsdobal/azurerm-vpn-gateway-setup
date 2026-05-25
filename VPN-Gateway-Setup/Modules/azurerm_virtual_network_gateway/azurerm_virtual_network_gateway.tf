resource "azurerm_virtual_network_gateway" "vnet-gateway" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.type
  vpn_type = var.vpn_type
  sku      = var.sku

  ip_configuration {
    name                          = var.ip_configuration.name == null ? "${var.name}-ipconfig" : var.ip_configuration.name
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    subnet_id                     = var.ip_configuration.subnet_id
    public_ip_address_id          = var.ip_configuration.public_ip_address_id
  }

  active_active                    = var.active-active
  default_local_network_gateway_id = var.default_local_network_gateway_id
  edge_zone                        = var.edge_zone
  bgp_enabled                      = var.bgp_enabled

  dynamic "bgp_settings" {
    for_each = var.bgp_settings == null ? [] : [var.bgp_settings]
    content {
      asn         = bgp_settings.value.asn
      peer_weight = bgp_settings.value.peer_weight

      dynamic "peering_addresses" {
        for_each = bgp_settings.value.peering_addresses == null ? [] : [bgp_settings.value.peering_addresses]
        content {
          ip_configuration_name = peering_addresses.value.ip_configuration_name
          apipa_addresses       = peering_addresses.value.apipa_addresses
        }
      }
    }
  }

  dynamic "custom_route" {
    for_each = var.custom_route == null ? [] : [var.custom_route]
    content {
      address_prefixes = custom_route.value.address_prefixes
    }
  }

  generation                            = var.generation
  private_ip_address_enabled            = var.private_ip_address_enabled
  bgp_route_translation_for_nat_enabled = var.bgp_route_translation_for_nat_enabled
  dns_forwarding_enabled                = var.dns_forwarding_enabled
  ip_sec_replay_protection_enabled      = var.ip_sec_replay_protection_enabled

  dynamic "policy_group" {
    for_each = var.policy_group == null ? [] : [var.policy_group]
    content {
      name       = coalesce(policy_group.value.name, "${name}-policy_group")
      is_default = policy_group.value.is_default
      priority   = policy_group.value.priority

      dynamic "policy_member" {
        for_each = policy_group.value.policy_member == null ? [] : [policy_group.value.policy_member]
        content {
          name  = coalesce(policy_member.value.name, "${name}-policy_member")
          type  = policy_member.value.type
          value = policy_member.value.value
        }
      }
    }
  }


  remote_vnet_traffic_enabled = var.remote_vnet_traffic_enabled
  virtual_wan_traffic_enabled = var.virtual_wan_traffic_enabled

  dynamic "vpn_client_configuration" {
    for_each = var.vpn_client_configuration == null ? [] : [var.vpn_client_configuration]
    content {
      address_space         = vpn_client_configuration.value.address_space
      aad_tenant            = vpn_client_configuration.value.aad_tenant
      aad_audience          = vpn_client_configuration.value.aad_audience
      aad_issuer            = vpn_client_configuration.value.aad_issuer
      radius_server_address = vpn_client_configuration.value.radius_server_address
      radius_server_secret  = vpn_client_configuration.value.radius_server_secret
      vpn_client_protocols  = vpn_client_configuration.value.vpn_client_protocols
      vpn_auth_types        = vpn_client_configuration.value.vpn_auth_types

      dynamic "ipsec_policy" {
        for_each = vpn_client_configuration.value.ipsec_policy == null ? [] : [vpn_client_configuration.value.ipsec_policy]
        content {
          dh_group                  = ipsec_policy.value.dh_group
          ike_encryption            = ipsec_policy.value.ike_encryption
          ike_integrity             = ipsec_policy.value.ike_integrity
          ipsec_encryption          = ipsec_policy.value.ipsec_encryption
          ipsec_integrity           = ipsec_policy.value.ipsec_integrity
          pfs_group                 = ipsec_policy.value.pfs_group
          sa_lifetime_in_seconds    = ipsec_policy.value.sa_lifetime_in_seconds
          sa_data_size_in_kilobytes = ipsec_policy.value.sa_data_size_in_kilobytes
        }
      }

      dynamic "root_certificate" {
        for_each = vpn_client_configuration.value.root_certificate == null ? [] : [vpn_client_configuration.value.root_certificate]
        content {
          name             = coalesce(root_certificate.value.name, "${name}-root_certificate")
          public_cert_data = root_certificate.value.public_cert_data
        }
      }

      dynamic "revoked_certificate" {
        for_each = vpn_client_configuration.value.revoked_certificate == null ? [] : [vpn_client_configuration.value.revoked_certificate]
        content {
          name       = coalesce(revoked_certificate.value.name, "${name}-revoked_certfificate")
          thumbprint = revoked_certfificate.value.thumbprint
        }
      }

      dynamic "radius_server" {
        for_each = vpn_client_configuration.value.radius_server == null ? [] : [vpn_client_configuration.value.radius_server]
        content {
          address = radius_server.value.address
          secret  = radius_server.value.secret
          score   = radius_server.value.score
        }
      }

      dynamic "virtual_network_gateway_client_connection" {
        for_each = vpn_client_configuration.value.virtual_network_gateway_client_connection == null ? [] : [vpn_client_configuration.value.virtual_network_gateway_client_connection]
        content {
          name               = coalesce(virtual_network_gateway_client_connection.value.name, "${name}-vnet_gw_client_connection")
          policy_group_names = virtual_network_gateway_client_connection.value.policy_group_names
          address_prefixes   = virtual_network_gateway_client_connection.value.address_prefixes
        }
      }

    }

  }

  tags = var.environment == null ? var.tags : merge({ environment = var.environment }, var.tags)

}
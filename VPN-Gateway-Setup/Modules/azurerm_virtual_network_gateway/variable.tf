variable "name" {
  description = "Specify the Name of VPN-Gateway"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "VNET Gateway name cannot be empty."
  }
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "ip_configuration" {
  type = object({
    name                          = optional(string, null)
    private_ip_address_allocation = optional(string, null)
    subnet_id                     = string
    public_ip_address_id          = optional(string, null)
  })
}

variable "sku" {
  type = string # (Basic), Standard, HighPerformance, UltraPerformance, ErGwScale, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ, 
}

variable "type" {
  type = string # (Vpn), Expressroute
}

variable "active-active" {
  type    = bool
  default = false
}

variable "default_local_network_gateway_id" {
  type     = string
  nullable = true
  default  = null
}

variable "edge_zone" {
  type     = string
  nullable = true
  default  = null
}

variable "bgp_enabled" {
  type    = bool
  default = false
}

#######
variable "bgp_settings" {
  type = object({
    asn         = optional(number, null)
    peer_weight = optional(number, 0) #Number between 0 to 100

    peering_addresses = optional(object({
      ip_configuration_name = optional(string, null)
      apipa_addresses       = optional(list(string), null) # valid range in azure public is 169.254.21.0 to 169.254.22.255
    }), null)
  })
  nullable = true
  default  = null
}

#######

variable "custom_route" {
  type = object({
    address_prefixes = optional(list(string), null)
  })
  nullable = true
  default  = null
}


variable "generation" {
  type     = string
  nullable = true
  default  = null #possible value = Generation1, Generation2, None
}

variable "private_ip_address_enabled" {
  type    = bool
  default = false
}

variable "bgp_route_translation_for_nat_enabled" {
  type    = bool
  default = false
}

variable "dns_forwarding_enabled" {
  type    = bool
  default = false
}

variable "ip_sec_replay_protection_enabled" {
  type    = bool
  default = true
}

#####

variable "policy_group" {
  type = object({
    name = optional(string, null)
    policy_member = optional(object({
      name  = string
      type  = string #AADGroupId, CertificateGroupId, RadiusAzureGroupId
      value = number
    }), null)
    is_default = optional(bool, false)
    priority   = optional(number, 0)
  })
  nullable = true
  default  = null
}

####

variable "remote_vnet_traffic_enabled" {
  type    = bool
  default = false
}

variable "virtual_wan_traffic_enabled" {
  type    = bool
  default = false
}


###########

variable "vpn_client_configuration" {
  type = object({
    address_space = list(string)
    aad_tenant    = optional(string, null)
    aad_audience  = optional(string, null)
    aad_issuer    = optional(string, null)

    ipsec_policy = optional(object({
      dh_group                  = string #DHGroup1, DHGroup2, DHGroup14, DHGroup24, DHGroup2048, ECP256, ECP384 and None.
      ike_encryption            = string #AES128, AES192, AES256, DES, DES3, GCMAES128 and GCMAES256
      ike_integrity             = string #GCMAES128, GCMAES256, MD5, SHA1, SHA256 and SHA384
      ipsec_encryption          = string #AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256 and None.
      ipsec_integrity           = string #GCMAES128, GCMAES192, GCMAES256, MD5, SHA1 and SHA256.
      pfs_group                 = string #ECP256, ECP384, PFS1, PFS2, PFS14, PFS24, PFS2048, PFSMM and None.
      sa_lifetime_in_seconds    = number #between 300 and 172799.
      sa_data_size_in_kilobytes = number #between 1024 and 2147483647.
    }), null)

    root_certificate = optional(object({
      name             = optional(string, null)
      public_cert_data = string
    }), null)

    revoked_certificate = optional(object({
      name       = optional(string, null)
      thumbprint = string
    }), null)

    radius_server = optional(object({
      address = string
      secret  = string
      score   = number #between 1 and 30
    }), null)

    radius_server_address = optional(string, null)
    radius_server_secret  = optional(string, null)
    vpn_client_protocols  = optional(list(string), null) #SSTP, IkeV2, OpenVPN
    vpn_auth_types        = optional(set(string), null)       #AAD, Radius, Certificate

    virtual_network_gateway_client_connection = optional(object({
      name               = optional(string, null)
      policy_group_names = list(string)
      address_prefixes   = list(string)
    }), null)

  })

  nullable = true
  default  = null
}

variable "vpn_type" {
  type     = string
  nullable = true
  default  = null #Possible Values = RouteBased, PolicyBased : Default=Routebased
}


variable "environment" {
  type    = string
  default = null
}

variable "tags" {
  type     = map(string)
  nullable = true
  default  = null
}




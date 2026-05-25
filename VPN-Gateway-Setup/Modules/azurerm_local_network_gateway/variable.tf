
variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "gateway_address" {
  type     = string
  nullable = true
  default  = null
}

variable "address_space" {
  type     = list(string)
  nullable = true
  default  = null
}

variable "gateway_fqdn" {
  type     = string
  nullable = true
  default  = null
}

variable "environment" {
  type = string
}

variable "tags" {
  type     = map(string)
  nullable = true
  default  = {}
}

variable "bgp_settings" {
  type = object({
    asn                 = string
    bgp_peering_address = string
    peer_weight         = optional(number)
  })
  nullable = true
  default  = null

}
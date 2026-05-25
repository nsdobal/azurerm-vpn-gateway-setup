variable "name" {
  description = "Specify the Name of Subnet"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "Subnet name cannot be empty for Subnet"
  }
}

variable "resource_group_name" {
  description = "Specify the Resource Group name, where this subnet will be created"
  type        = string
}

variable "virtual_network_name" {
  description = "Specify Name of VNET, where this SUBNET will create"
  type        = string
}

variable "address_prefixes" {
  description = "Specify CIDR range for Subnet"
  type        = list(string)

  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "Address_prefix can not be empty for Subnet, Atleast 1 CIDR range need to be provided"
  }
}

variable "service_endpoints" {
  description = "Specify Service Endpoints for Subnet, if needed"
  type        = list(string)
  default     = null
}



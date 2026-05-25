variable "name" {
  description = "Name of vnet"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "VNET name cannot be empty"
  }
}

variable "resource_group_name" {
  description = "Mention Resource Group Name where VNET will be created"
  type        = string
}



variable "location" {
  description = "Metion the region where VNET will be created"
  type        = string
}


variable "address_space" {
  description = "List of CIDR ranges for VNET"
  type        = list(string)

  validation {
    condition     = length(var.address_space) > 0
    error_message = "Atleast 1 address_space must be defined"
  }
}


variable "dns_servers" {
  description = "Mention list of IPs of Custom DNS_Server"
  type        = list(string)
  default     = null
}

variable "environment" {
  description = "Specify the environment : dev, test, prod"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], lower(var.environment))
    error_message = "Environments must be dev, test or prod"
  }
}

variable "tags" {
  description = "Add tags for VNET"
  type        = map(string)
  default     = null

  validation {
    condition     = length(var.tags) <= 10
    error_message = "Too many tags, Maximum 10 tags are allowed."
  }
}


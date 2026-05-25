variable "name" {
  description = "Specify Name of Public-IP"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty for Public_IP"
  }
}


variable "resource_group_name" {
  type        = string
}


variable "location" {
  type        = string
}

variable "allocation_method" {
  type        = string
}


variable "environment" {
  type        = string
}

variable "tags" {
  description = "Add the tags for Public-IP, if needed (max-10)"
  type        = map(string)

  validation {
    condition     = length(var.tags) <= 10
    error_message = "Too many tags, Maximum 10 tags are allowed"
  }
}

variable "sku" {
  type = string
}

variable "sku_tier" {
  type = string  
  nullable = true
  default = null
}

variable "zones" {
  type = list (string)  
  nullable = true
  default = null
}


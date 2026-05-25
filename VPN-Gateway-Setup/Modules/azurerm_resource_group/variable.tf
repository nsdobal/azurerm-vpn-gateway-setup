variable "name" {
  description = "Name of the Resource Group"
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "Resource Group name cannot be empty"
  }
}


variable "location" {
  description = "Give the Region, where the RG will be created"
  type        = string

  validation {
    condition     = contains(["centralindia", "eastus", "westus2", "sounthasia","malaysiawest"], lower(var.location))
    error_message = "location is not allowed, Please look for validation condition in resourcegroup module"
  }
}

variable "environment" {
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod", "stage"], lower(var.environment))
    error_message = "Environment can be dev, test or prod & stage"
  }
  nullable = true
  default = null
}

variable "managed_by" {
  type = string
  nullable = true
  default = null
}

variable "tags" {
  description = "Tags to apply with RG, max 10 tags"
  type        = map(string)

  validation {
    condition     = length(var.tags) <= 10
    error_message = "Too many tags, Maximum 10 tags are allowed."
  }
}
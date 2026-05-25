# terraform {
#   backend "azurerm" {
#     resource_group_name  = "nd-rg-tfstate"
#     storage_account_name = "ndstorageaccounttfstate1"
#     container_name       = "value"
#     key                  = "vpn-gateway.tfstate"
#   }
# }
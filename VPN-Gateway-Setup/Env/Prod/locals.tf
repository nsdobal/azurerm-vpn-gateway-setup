# #### Windows VM ####

# ## Default parameters for the dev environment
# locals {
#   vm_defaults = {
#     location            = "centralindia"
#     resource_group_name = "dev-rg"
#     enable_pip          = false

#     vm_size           = "Standard_B2ls_v2"
#     public_ip_address = null

#     admin_username = "azure"
#     admin_password = "Welcome@12345"

#     # storage_os_disk = {
#     #     name          = "os-disk-name"
#     #     create_option = "FromImage"
#     #     caching       = "ReadWrite"
#     #     disk_size_gb  = 130
#     #     os_type       = "Windows"
#     # }

#     storage_image_reference = {
#       publisher = "microsoftwindowsserver"
#       offer     = "windowsserver2022"
#       sku       = "2022-datacenter-azure-edition"
#       version   = "latest"
#     }
#     environment = "dev"
#   }
# }

# ## MERGING default values and variable passed inputs
# locals {
#   vms_merged = {
#     for k, v in var.vms :
#     k => merge(local.vm_defaults, v)
#   }
# }

# locals {
#   vms_final = {
#     for k, v in var.vms :
#     k => {
#       name                = v.name
#       location            = coalesce(v.location, local.vm_defaults.location)
#       resource_group_name = coalesce(v.resource_group_name, local.vm_defaults.resource_group_name)
#       enable_pip          = coalesce(v.enable_pip, local.vm_defaults.enable_pip)

#       subnet            = v.subnet
#       public_ip_address = v.public_ip_address
#       vm_size           = coalesce(v.vm_size, local.vm_defaults.vm_size)
#       # license_type = coalesce (v.license_type, local.vms_merged.license_type)    

#       admin_username = local.vm_defaults.admin_username
#       admin_password = local.vm_defaults.admin_password

#       storage_image_reference = coalesce(v.storage_image_reference, local.vm_defaults.storage_image_reference)

#       environment = coalesce(v.environment, local.vm_defaults.environment)
#       tags        = v.tags

#     }
#   }

# }
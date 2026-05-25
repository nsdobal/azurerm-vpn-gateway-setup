#### RG ####

rg = {
  nd-vpngw-dev-rg = {
    name        = "nd-vpngw-dev-rg"
    location    = "centralindia"
    environment = "dev"
    #   tags = {}
  }
}


#### VNET ####

vnets = {
  nd-vpngw-vnet = {
    name                = "nd-vpngw-vnet"
    resource_group_name = "nd-vpngw-dev-rg"
    location            = "centralindia"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = []
    environment         = "dev"
    tags                = { owner = "nd" }
  }
}

#### Subnet ####

subnets = {

  GatewaySubnet = {
    name                 = "GatewaySubnet"
    resource_group_name  = "nd-vpngw-dev-rg"
    virtual_network_name = "nd-vpngw-vnet"
    address_prefixes     = ["10.0.1.0/24"]
    # service_endpoints =[]
  }

  nd-vpngw-subnet1 = {
    name                 = "nd-vpngw-subnet1"
    resource_group_name  = "nd-vpngw-dev-rg"
    virtual_network_name = "nd-vpngw-vnet"
    address_prefixes     = ["10.0.10.0/24"]
  }
}

#### PIP ####

pip = {
  nd-vpngw-pip1-ind = {
    name                = "nd-vpngw-pip1-ind"
    resource_group_name = "nd-vpngw-dev-rg"
    location            = "centralindia"
    allocation_method   = "Static"
    environment         = "dev"
    tags                = { owner = "nd" }
  }
}

#### VPN Gateway ####

vpn-gateway = {
  "nd-vpngw1-ind" = {
    name                       = "nd-vpngw1-ind"
    location                   = "centralindia"
    resource_group_name        = "nd-vpngw-dev-rg"
    private_ip_address_enabled = true
    sku                        = "VpnGw1AZ"
    ip_configuration = {
      subnet_name       = "GatewaySubnet"
      public_ip_address = "nd-vpngw-pip1-ind"
    }
    vpn_client_configuration = {
      address_space = ["172.16.201.0/24"]
    }
  }
}

#### Local_Network_Gateway ####

Local_Network_Gateway = {
  "Local-nw-gw-ind" = {
    name                = "Local-nw-gw-ind"
    location            = "centralindia"
    resource_group_name = "nd-vpngw-dev-rg"
    address_space       = ["10.1.0.0/16"]
    gateway_address     = "85.211.211.232" #Public IP of another side network
  }
}

#### VNET_Gateway_Connection ####

VNET_Gateway_Connection = {
  "nd-cenind-gw-conn-ind" = {
    name                    = "nd-cenind-gw-conn-ind"
    resource_group_name     = "nd-vpngw-dev-rg"
    location                = "centralindia"
    type                    = "IPsec"
    virtual_network_gateway = "nd-vpngw1-ind"
    local_network_gateway   = "Local-nw-gw-ind"
    shared_key              = "Q7#vL2@xM9!rT4$kP8&wY1^cN6*bF3!sH5"

  }
}


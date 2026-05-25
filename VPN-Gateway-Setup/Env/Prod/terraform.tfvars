#### RG ####

rg = {
  nd-vpngw-prod-rg = {
    name        = "nd-vpngw-prod-rg"
    location    = "malaysiawest"
    environment = "prod"
    #   tags = {}
  }
}


#### VNET ####

vnets = {
  nd-vpngw-prod-vnet = {
    name                = "nd-vpngw-prod-vnet"
    resource_group_name = "nd-vpngw-prod-rg"
    location            = "malaysiawest"
    address_space       = ["10.1.0.0/16"] # VNET-A & VNET-B should have different address_space for tunneling
    dns_servers         = []
    environment         = "prod"
    tags                = { owner = "nd" }
  }
}

#### Subnet ####

subnets = {

  GatewaySubnet = {
    name                 = "GatewaySubnet"
    resource_group_name  = "nd-vpngw-prod-rg"
    virtual_network_name = "nd-vpngw-prod-vnet"
    address_prefixes     = ["10.1.1.0/24"]
    # service_endpoints =[]
  }

  nd-vpngw-subnet1 = {
    name                 = "nd-vpngw-subnet1"
    resource_group_name  = "nd-vpngw-prod-rg"
    virtual_network_name = "nd-vpngw-prod-vnet"
    address_prefixes     = ["10.1.10.0/24"]
  }
}

#### PIP ####

pip = {
  nd-vpngw-prod-pip1-mal = {
    name                = "nd-vpngw-prod-pip1-mal"
    resource_group_name = "nd-vpngw-prod-rg"
    location            = "malaysiawest"
    allocation_method   = "Static"
    environment         = "dev"
    tags                = { owner = "nd" }
  }
}

#### VPN Gateway ####

vpn-gateway = {
  "nd-vpngw-prod-mal" = {
    name                       = "nd-vpngw-prod-mal"
    location                   = "malaysiawest"
    resource_group_name        = "nd-vpngw-prod-rg"
    private_ip_address_enabled = true
    sku                        = "VpnGw1AZ"
    ip_configuration = {
      subnet_name       = "GatewaySubnet"
      public_ip_address = "nd-vpngw-prod-pip1-mal"
    }
    vpn_client_configuration = {
      address_space = ["172.17.201.0/24"]
    }
  }
}

#### Local_Network_Gateway ####

Local_Network_Gateway = {
  "Local-nw-gw-mal" = {
    name                = "Local-nw-gw-mal"
    location            = "malaysiawest"
    resource_group_name = "nd-vpngw-prod-rg"
    address_space       = ["10.0.0.0/16"]
    gateway_address     = "4.247.240.143"
  }
}

#### VNET_Gateway_Connection ####

VNET_Gateway_Connection = {
  "nd-malwest-gw-conn-mal" = {
    name                    = "nd-malwest-gw-conn-mal"
    resource_group_name     = "nd-vpngw-prod-rg"
    location                = "malaysiawest"
    type                    = "IPsec"
    virtual_network_gateway = "nd-vpngw-prod-mal"
    local_network_gateway   = "Local-nw-gw-mal"
    shared_key              = "Q7#vL2@xM9!rT4$kP8&wY1^cN6*bF3!sH5"

  }
}



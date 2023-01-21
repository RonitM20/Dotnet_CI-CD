#variables
variable "vnet_name" {
  default = "terra_net"
}
variable "cidr" {
  default = ["8.0.0.0/16"]
}
variable "subnet" {
  type    = list(string)
  default = ["app", "database"]
}
variable "subnet_range" {
  type    = list(string)
  default = ["8.0.0.0/24", "8.0.1.0/24"]
}

#provider
provider "azurerm" {
  features {}
}

#resource
module "vnet" {
  source              = "Azure/vnet/azurerm"
  version             = "3.2.0"
  resource_group_name = "terraform_rg"
  vnet_location       = "east us"
  vnet_name           = var.vnet_name
  address_space       = var.cidr
  subnet_names        = var.subnet
  subnet_prefixes     = var.subnet_range
  nsg_ids             = {}

  tags = {
    enviroment = "dev"
    app        = "terraform"
  }
}

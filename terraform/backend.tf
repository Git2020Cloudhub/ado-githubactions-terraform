terraform {
  backend "azurerm" {
    resource_group_name  = "adogithubtf-rg"
    storage_account_name = "tfstateadogithubtf"   # must match storage.tf
    container_name       = "state"
    key                  = "demo.terraform.tfstate"
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "adogithubtf-rg"
    storage_account_name = "tfstateadogithubaction"  # ≤ 24 chars
    container_name       = "state"
    key                  = "demo.terraform.tfstate"
  }
}

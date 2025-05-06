resource "azurerm_storage_account" "state" {
  name                     = "tfstate${replace(var.rg_name, "/-/", "")}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state" {
  name                  = "state"
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
}
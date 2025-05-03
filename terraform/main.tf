provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "acr${var.acr_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# …plus the App Service and other resources…
resource "azurerm_app_service_plan" "plan" { … }

# classic App Service
resource "azurerm_app_service" "appadogithubactionsterraform" {
  name                = "web-${var.rg_name}"
  app_service_plan_id = azurerm_app_service_plan.plan.id
  …
}

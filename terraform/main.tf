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

resource "azurerm_app_service_plan" "plan" {
  name                = "plan-${var.rg_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
  reserved = true
}

resource "azurerm_linux_web_app" "app" {
  name                = "web-${var.rg_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.plan.id

  identity { type = "SystemAssigned" }

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/${var.image_name}:latest"
  }

  depends_on = [azurerm_container_registry.acr]
}

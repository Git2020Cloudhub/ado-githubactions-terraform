provider "azurerm" {
  features {}
}

#── Resource Group ─────────────────────────────────────────────────────────────
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

#── Container Registry ──────────────────────────────────────────────────────────
resource "azurerm_container_registry" "acr" {
  name                = "acr${var.acr_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

#── App Service Plan (Linux) ───────────────────────────────────────────────────
resource "azurerm_app_service_plan" "plan" {
  name                = "plan-${var.rg_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Basic"
    size = "B1"
  }

  # reserved = true makes this Linux‑compatible
  reserved = true
}

#── Linux Web App (container) ─────────────────────────────────────────────────
resource "azurerm_linux_web_app" "app" {
  name                = "web-${var.rg_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    # Pull the image you built & pushed in CI
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/${var.image_name}:latest"
  }

  # Ensure ACR exists before creating the Web App
  depends_on = [azurerm_container_registry.acr]
}

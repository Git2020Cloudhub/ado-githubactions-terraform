resource "azuread_application" "gha" {
  display_name = "github-actions-sp"
}

resource "azuread_service_principal" "gha" {
  application_id = azuread_application.gha.application_id
}

resource "random_password" "gha_pw" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "gha_secret" {
  service_principal_id = azuread_service_principal.gha.id
  value                = random_password.gha_pw.result
  end_date_relative    = "8760h"
}

resource "azurerm_role_assignment" "gha_contrib" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.gha.id
}

data "azurerm_client_config" "current" {}

locals {
  azure_credentials = jsonencode({
    clientId                        = azuread_application.gha.application_id
    clientSecret                    = random_password.gha_pw.result
    subscriptionId                  = var.subscription_id
    tenantId                        = data.azurerm_client_config.current.tenant_id
    activeDirectoryEndpointUrl     = "https://login.microsoftonline.com"
    resourceManagerEndpointUrl     = "https://management.azure.com/"
    activeDirectoryGraphResourceId = "https://graph.windows.net/"
    sqlManagementEndpointUrl       = "https://management.azure.com/"
    galleryEndpointUrl             = "https://gallery.azure.com/"
    managementEndpointUrl          = "https://management.azure.com/"
  })
}

resource "github_actions_secret" "azure_creds" {
  repository      = var.github_repository
  secret_name     = "AZURE_CREDENTIALS"
  plaintext_value = local.azure_credentials
}

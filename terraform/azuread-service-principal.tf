// AAD Service Principal and password

# 1 Application
resource "azuread_application" "gha" {
  display_name = "github-actions-sp"
}

# 2 Service Principal for that app
resource "azuread_service_principal" "gha" {
  application_id = azuread_application.gha.application_id
}

# 3 A password / secret for the SP
resource "azuread_service_principal_password" "gha" {
  service_principal_id = azuread_service_principal.gha.id
  value                = random_password.pw.result
  end_date_relative    = "8760h"     # 1 year
}

# 4 Give it Contributor on your RG
resource "azurerm_role_assignment" "gha_rg_contributor" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.gha.id
}

# 5 Random password generation
resource "random_password" "pw" {
  length  = 20
  special = true
}

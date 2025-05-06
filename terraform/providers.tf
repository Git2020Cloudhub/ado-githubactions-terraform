terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
}

provider "github" {
  token = var.github_token    // a PAT with repo/workflow scopes
  owner = var.github_owner    // e.g. "Git2020Cloudhub"
}

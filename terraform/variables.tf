variable "github_token" {
  description = "GitHub PAT with admin:repo_hook, repo & workflow scopes"
  type        = string
}

variable "github_owner" {
  description = "GitHub org or user that owns the repo"
  type        = string
}

variable "github_repository" {
  description = "Name of the repo (e.g. ado-githubactions-terraform)"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID to grant to the SP"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID to grant to the SP"
  type        = string
}

variable "github_token" {
  description = "GitHub PAT with repo & workflow scopes"
  type        = string
}

variable "github_owner" {
  description = "GitHub org/user name"
  type        = string
}

variable "github_repository" {
  description = "GitHub repo name (e.g. ado-githubactions-terraform)"
  type        = string
}

#
variable "rg_name"     { default = "adogithubtf-rg" }
variable "location"    { default = "uksouth" }
variable "acr_suffix"  { default = "adogithubtf" }
variable "image_name"  { default = "ado-github-terraform-demo" }
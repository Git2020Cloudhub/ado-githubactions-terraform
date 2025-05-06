variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "adogithubtf-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "uksouth"
}

variable "acr_suffix" {
  description = "Suffix for ACR name"
  type        = string
  default     = "adogithubtf"
}

variable "image_name" {
  description = "Docker image name"
  type        = string
  default     = "ado-github-terraform-demo"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "github_owner" {
  description = "GitHub org/user"
  type        = string
}

variable "github_repository" {
  description = "GitHub repo name"
  type        = string
}

variable "github_token" {
  description = "GitHub PAT with repo & workflow scopes"
  type        = string
  sensitive   = true
}

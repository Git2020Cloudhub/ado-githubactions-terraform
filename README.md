# ado-githubactions-terraform
ado-githubactions-terraform


az login 
select subscription id 
 az ad sp create-for-rbac \
  --name "github-actions-sp" \
  --role contributor \
  --scopes /subscriptions/75dbdf16-ae16-43a3-a867-a199900f39be \
  --sdk-auth


  # ADO + GitHub Actions + Terraform Demo

This repo shows how to:

1. Use Terraform to:
   - Create an RG, Storage Account (for state), ACR, App Service Plan, and Linux Web App.
   - Bootstrap GitHub Actions credentials (`AZURE_CREDENTIALS`) from Terraform.
2. Use GitHub Actions to:
   - Deploy the infra (`deploy-infra` job).
   - Build & push a Docker image to ACR (`build-push` job).
   - Deploy to your Web App automatically.

### Getting started

- Populate **terraform/terraform.tfvars** with:
  ```hcl
  subscription_id   = "<your-subscription-id>"
  github_owner      = "<your-github-org-or-user>"
  github_repository = "ado-githubactions-terraform"
  github_token      = "<PAT with repo & workflow scopes>"

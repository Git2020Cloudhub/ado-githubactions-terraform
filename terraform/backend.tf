 terraform {
   backend "azurerm" {
     resource_group_name  = "adogithubtf-rg"
-    storage_account_name = "tfstateadogithubaction"
+    storage_account_name = "tfstateadogithubtf"   # ← match storage.tf / Azure portal
     container_name       = "state"
     key                  = "demo.terraform.tfstate"
   }
 }

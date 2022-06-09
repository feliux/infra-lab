terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.4.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.5.6"
    }
  }
}

provider "azurerm" {
  environment = "public"
  features {

  }

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "databricks" {
  host                        = azurerm_databricks_workspace.az_databricks.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.az_databricks.id
  azure_client_id             = var.client_id
  azure_client_secret         = var.client_secret
  azure_tenant_id             = var.tenant_id
}

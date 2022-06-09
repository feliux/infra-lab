resource "azurerm_resource_group" "azure_rg" {
  name     = var.azure_rosources.resource_group_name
  location = var.azure_rosources.location
}

resource "azurerm_databricks_workspace" "az_databricks" {
  name                              = var.azure_rosources.databricks_name
  resource_group_name               = azurerm_resource_group.azure_rg.name
  location                          = azurerm_resource_group.azure_rg.location
  sku                               = var.azure_rosources.databricks_sku
  managed_resource_group_name       = var.azure_rosources.managed_resource_group_name       # Has to be unique
  customer_managed_key_enabled      = var.azure_rosources.customer_managed_key_enabled      # true only if sku = "premium"
  infrastructure_encryption_enabled = var.azure_rosources.infrastructure_encryption_enabled # true only if sku = "premium"
  public_network_access_enabled     = var.azure_rosources.public_network_access_enabled

  tags = {
    Environment = var.environment
  }
}

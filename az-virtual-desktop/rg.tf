resource "azurerm_resource_group" "resource_group" {
  name     = "${var.company.name}resource_group"
  location = var.company.location
}

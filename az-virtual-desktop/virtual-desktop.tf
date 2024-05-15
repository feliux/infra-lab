resource "azurerm_virtual_desktop_host_pool" "host_pool" {
  location                         = azurerm_resource_group.resource_group.location
  resource_group_name              = azurerm_resource_group.resource_group.name
  name                             = "${var.company.name}host_pool"
  friendly_name                    = "${var.company.name}host_pool"
  validate_environment             = false
  start_vm_on_connect              = true
  custom_rdp_properties            = "audiocapturemode:i:1;audiomode:i:0;usbdevicestoredirect:s:*"
  description                      = "${var.company.name}host_pool"
  type                             = "Pooled"
  maximum_sessions_allowed         = 5
  load_balancer_type               = "DepthFirst"
  preferred_app_group_type         = "Desktop"
  personal_desktop_assignment_type = "Automatic" // "Direct" when admin
  tags = {
    terraform = true
  }
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "${var.company.name}workspace"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  friendly_name       = "${var.company.name}workspace"
  description         = "${var.company.name}workspace"
  tags = {
    terraform = true
  }
}

resource "azurerm_virtual_desktop_application_group" "remote_app" {
  name                = "${var.company.name}remote_app1"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  type                = "RemoteApp"
  host_pool_id        = azurerm_virtual_desktop_host_pool.host_pool.id
  friendly_name       = "${var.company.name}-RemoteApp-ApplicationGroup"
  description         = "${var.company.name}-RemoteApp-ApplicationGroup"
  tags = {
    terraform = true
  }
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "workspace_remote_app" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.remote_app.id
}

resource "azurerm_virtual_desktop_application" "chrome" {
  name                         = "googlechrome"
  application_group_id         = azurerm_virtual_desktop_application_group.remote_app.id
  friendly_name                = "Google Chrome"
  description                  = "Chromium based web browser"
  path                         = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
  command_line_argument_policy = "DoNotAllow"
  command_line_arguments       = "--incognito"
  show_in_portal               = false
  icon_path                    = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
  icon_index                   = 0
}

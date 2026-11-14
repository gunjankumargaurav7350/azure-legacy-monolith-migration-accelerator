resource "azurerm_service_plan" "this" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on           = var.always_on
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"
    http2_enabled       = true
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  tags = var.tags
}

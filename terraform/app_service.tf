terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "monolith_rg" {
  name     = "rg-monolith-modernization-prod"
  location = "eastus"
  tags = {
    Environment = "Production"
    Workload    = "Legacy-Monolith-Migration"
    MigrationLead = "Gunjan Kumar Gaurav"
  }
}

# -------------------------------------------------------------------------------------------------
# App Service Environment with VNet Integration & Session State Redis
# -------------------------------------------------------------------------------------------------
resource "azurerm_service_plan" "monolith_plan" {
  name                = "asp-monolith-prod"
  resource_group_name = azurerm_resource_group.monolith_rg.name
  location            = azurerm_resource_group.monolith_rg.location
  os_type             = "Linux"
  sku_name            = "P2v3"
}

resource "azurerm_linux_web_app" "monolith_app" {
  name                = "app-monolith-core-prod-01"
  resource_group_name = azurerm_resource_group.monolith_rg.name
  location            = azurerm_resource_group.monolith_rg.location
  service_plan_id     = azurerm_service_plan.monolith_plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on        = true
    ftps_state       = "Disabled"
    minimum_tls_version = "1.2"
    http2_enabled    = true
    application_stack {
      dotnet_version = "8.0"
    }
  }

  tags = azurerm_resource_group.monolith_rg.tags
}

resource "azurerm_redis_cache" "session_cache" {
  name                = "redis-monolith-session-prod"
  location            = azurerm_resource_group.monolith_rg.location
  resource_group_name = azurerm_resource_group.monolith_rg.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  tags = azurerm_resource_group.monolith_rg.tags
}

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
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# -------------------------------------------------------------------------------------------------
# Modular App Services Deployment using for_each
# -------------------------------------------------------------------------------------------------
module "web_apps" {
  source   = "./modules/app_service"
  for_each = var.web_apps

  resource_group_name = azurerm_resource_group.monolith_rg.name
  location            = azurerm_resource_group.monolith_rg.location
  service_plan_name   = each.value.service_plan_name
  app_name            = each.key
  sku_name            = each.value.sku_name
  os_type             = each.value.os_type
  always_on           = each.value.always_on
  dotnet_version      = each.value.dotnet_version
  tags                = merge(azurerm_resource_group.monolith_rg.tags, each.value.tags)
}

# -------------------------------------------------------------------------------------------------
# Session State Redis Caches Deployment using for_each
# -------------------------------------------------------------------------------------------------
resource "azurerm_redis_cache" "session_cache" {
  for_each = var.redis_caches

  name                = each.key
  location            = azurerm_resource_group.monolith_rg.location
  resource_group_name = azurerm_resource_group.monolith_rg.name
  capacity            = each.value.capacity
  family              = each.value.family
  sku_name            = each.value.sku_name
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  tags = merge(azurerm_resource_group.monolith_rg.tags, each.value.tags)
}

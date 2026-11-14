output "web_app_id" {
  value = azurerm_linux_web_app.this.id
}

output "web_app_default_hostname" {
  value = azurerm_linux_web_app.this.default_hostname
}

output "service_plan_id" {
  value = azurerm_service_plan.this.id
}

output "principal_id" {
  value = azurerm_linux_web_app.this.identity[0].principal_id
}

output "web_app_hostnames" {
  description = "Default hostnames of the deployed App Services"
  value       = { for k, v in module.web_apps : k => v.web_app_default_hostname }
}

output "web_app_ids" {
  description = "Resource IDs of the deployed App Services"
  value       = { for k, v in module.web_apps : k => v.web_app_id }
}

output "redis_cache_hostnames" {
  description = "Hostnames of the session state Redis instances"
  value       = { for k, v in azurerm_redis_cache.session_cache : k => v.hostname }
}

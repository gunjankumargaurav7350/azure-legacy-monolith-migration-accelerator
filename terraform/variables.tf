variable "resource_group_name" {
  type        = string
  default     = "rg-monolith-modernization-prod"
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure Region"
}

variable "tags" {
  type = map(string)
  default = {
    Environment   = "Production"
    Workload      = "Legacy-Monolith-Migration"
    MigrationLead = "Gunjan Kumar Gaurav"
    ManagedBy     = "Terraform"
  }
}

variable "web_apps" {
  type = map(object({
    service_plan_name = string
    sku_name          = optional(string, "P2v3")
    os_type           = optional(string, "Linux")
    always_on         = optional(bool, true)
    dotnet_version    = optional(string, "8.0")
    tags              = optional(map(string), {})
  }))
  default = {
    "app-monolith-core-prod-01" = {
      service_plan_name = "asp-monolith-prod"
      sku_name          = "P2v3"
      os_type           = "Linux"
      always_on         = true
      dotnet_version    = "8.0"
      tags              = { Tier = "Core-Application" }
    }
  }
}

variable "redis_caches" {
  type = map(object({
    capacity = optional(number, 2)
    family   = optional(string, "C")
    sku_name = optional(string, "Standard")
    tags     = optional(map(string), {})
  }))
  default = {
    "redis-monolith-session-prod" = {
      capacity = 2
      family   = "C"
      sku_name = "Standard"
      tags     = { Purpose = "DistributedSessionState" }
    }
  }
}

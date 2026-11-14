variable "resource_group_name" {
  type        = string
  description = "Target Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "service_plan_name" {
  type        = string
  description = "App Service Plan Name"
}

variable "os_type" {
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  type        = string
  default     = "P2v3"
}

variable "app_name" {
  type        = string
  description = "Linux Web App Name"
}

variable "always_on" {
  type        = bool
  default     = true
}

variable "dotnet_version" {
  type        = string
  default     = "8.0"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

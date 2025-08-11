variable "name" {
  description = "The name of the Function App."
  type        = string
}

variable "location" {
  description = "The Azure location for the Function App."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account for the Function App."
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
  type        = string
}

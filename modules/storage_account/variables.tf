variable "name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location for the storage account."
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the storage account."
  type        = string
  default     = "LRS"
}

variable "storage_user_assigned_identity_id" {
  description = "The ID of the user assigned identity to be used for customer managed key."
  type        = string
}

variable "storage_key_vault_key_id" {
  description = "The Key Vault key ID for customer managed keys."
  type        = string
  default     = null
  
}
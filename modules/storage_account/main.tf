resource "azurerm_storage_account" "this" {
  public_network_access_enabled = true
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  customer_managed_key {
    user_assigned_identity_id = var.storage_user_assigned_identity_id
    key_vault_key_id          = var.storage_key_vault_key_id
  }
}

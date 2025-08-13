resource "azurerm_storage_account" "this_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "FC1"
}

resource "azurerm_function_app_flex_consumption" "this" {
  public_network_access_enabled = true
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  # storage_account_id removed as it is not expected
  storage_authentication_type = "accountKey"
  storage_container_type      = "blob"
  storage_container_endpoint  = azurerm_storage_account.this_storage.primary_blob_endpoint
  runtime_name       = "python"
  runtime_version    = "3.11"
  site_config {
    application_insights_connection_string = null
  }
}

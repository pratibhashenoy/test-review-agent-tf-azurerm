
# output "id" {
#   value = azurerm_function_app_flex_consumption.function_app_flex[0].id
# }

output "id" {
  value = var.flex_consumption_function_app && var.service_plan_sku == "FC1" ? azurerm_function_app_flex_consumption.function_app_flex[0].id : null
}

# Example output when using for_each
# output "function_app_id" {
#   value = try(azurerm_function_app_flex_consumption.function_app_flex["enabled"].id, null)
# }


# output "custom_domain_verification_id" {
#   value = azurerm_function_app_flex_consumption.function_app_flex[0].custom_domain_verification_id
# }

# output "default_hostname" {
#   value = azurerm_function_app_flex_consumption.function_app_flex[0].default_hostname
# }

# output "hosting_environment_id" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.hosting_environment_id
# }

# output "identity" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.identity
# }

# output "kind" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.kind
# }

# output "outbound_ip_address_list" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.outbound_ip_address_list
# }

# output "outbound_ip_addresses" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.outbound_ip_addresses
# }

# output "possible_outbound_ip_address_list" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.possible_outbound_ip_address_list
# }

# output "possible_outbound_ip_addresses" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.possible_outbound_ip_addresses
# }

# output "site_credential" {
#   value = azurerm_function_app_flex_consumption.function_app_flex.site_credential
# }
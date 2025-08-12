variable "name" {
  description = "Name of the Function App."
  type        = string
}

variable "location" {
  description = "Azure region for resources."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "service_plan_id" {
  description = "ID of the App Service Plan."
  type        = string
}

variable "storage_container_type" {
  description = "The storage container type used for the Function App."
  type        = string
}

variable "storage_container_endpoint" {
  description = "The backend storage container endpoint."
  type        = string
}

variable "storage_authentication_type" {
  description = "The authentication type for backend storage account."
  type        = string
}

variable "runtime_name" {
  description = "The runtime of the Linux Function App."
  type        = string
}

variable "runtime_version" {
  description = "The runtime version of the Linux Function App."
  type        = string
}

variable "enabled" {
  description = "Is the Function App enabled?"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled?"
  type        = bool
  default     = true
}

variable "storage_access_key" {
  description = "The access key for the backend storage account."
  type        = string
  default     = null
}

variable "storage_user_assigned_identity_id" {
  description = "The user assigned Managed Identity to access the storage account."
  type        = string
  default     = null
}

variable "maximum_instance_count" {
  description = "The number of workers this function app can scale out to."
  type        = number
  default     = null
}

variable "instance_memory_in_mb" {
  description = "The memory size of the instances."
  type        = number
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the Function App."
  type        = map(string)
  default     = {}
}

variable "virtual_network_subnet_id" {
  description = "The subnet id for regional virtual network integration."
  type        = string
  default     = null
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "Should WebDeploy Basic Authentication publishing credentials be enabled?"
  type        = bool
  default     = true
}

variable "zip_deploy_file" {
  description = "The local path and filename of the Zip packaged application to deploy."
  type        = string
  default     = null
}

variable "app_settings" {
  description = "A map of key-value pairs for App Settings."
  type        = map(string)
  default     = null
}

variable "auth_settings" {
  description = "A list of auth_settings blocks."
  type        = any
  default     = null
}

# variable "auth_settings_v2" {
#   description = "A list of auth_settings_v2 blocks."
#   type = list(object({
#     auth_enabled                            = optional(bool)
#     runtime_version                         = optional(string)
#     config_file_path                        = optional(string)
#     require_authentication                  = optional(bool)
#     unauthenticated_action                  = optional(string)
#     default_provider                        = optional(string)
#     excluded_paths                          = optional(list(string))
#     require_https                           = optional(bool)
#     http_route_api_prefix                   = optional(string)
#     forward_proxy_convention                = optional(string)
#     forward_proxy_custom_host_header_name   = optional(string)
#     forward_proxy_custom_scheme_header_name = optional(string)
#     active_directory_v2                     = optional(any)
#     custom_oidc_v2                          = optional(any)
#     login                                   = optional(any)
#   }))
#   default = null
# }

variable "auth_settings_v2" {
  description = "A list of auth_settings_v2 blocks."
  type = any
  default = null
  
}

variable "client_certificate_enabled" {
  description = "Should the function app use Client Certificates."
  type        = bool
  default     = null
}

variable "client_certificate_mode" {
  description = "The mode of the Function App's client certificates requirement."
  type        = string
  default     = null
}

variable "client_certificate_exclusion_paths" {
  description = "Paths to exclude when using client certificates."
  type        = string
  default     = null
}

variable "connection_string" {
  description = "A list of connection_string blocks."
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = null
}

variable "identity" {
  description = "A list of identity blocks."
  type        = any
  default     = null
}

variable "always_ready" {
  description = "A list of always_ready blocks."
  type = list(object({
    name           = string
    instance_count = number
  }))
  default = null
}

variable "sticky_settings_enabled" {
  description = "Enable or disable sticky settings"
  type        = bool
  default     = false
}

variable "sticky_app_setting_names" {
  description = "A list of app setting names to be sticky."
  type        = list(string)
  default     = []

}
variable "sticky_connection_string_names" {
  description = "A list of connection string names to be sticky."
  type        = list(string)
  default     = []
}


# variable "site_config" {
#   description = "A map/object for the site_config block."
#   type = object({
#     api_definition_url                     = optional(string)
#     api_management_api_id                  = optional(string)
#     app_command_line                       = optional(string)
#     application_insights_connection_string = optional(string)
#     application_insights_key               = optional(string)
#     app_service_logs = optional(object({
#       disk_quota_mb         = optional(number)
#       retention_period_days = optional(number)
#     }))
#     container_registry_managed_identity_client_id = optional(string)
#     container_registry_use_managed_identity       = optional(bool)
#     cors                                          = optional(any)
#     default_documents                             = optional(list(string))
#     health_check_path                             = optional(string)
#     health_check_eviction_time_in_min             = optional(number)
#     http2_enabled                                 = optional(bool)
#     ip_restriction                                = optional(any)
#     ip_restriction_default_action                 = optional(string)
#     load_balancing_mode                           = optional(string)
#     managed_pipeline_mode                         = optional(string)
#     minimum_tls_version                           = optional(string)
#     remote_debugging_enabled                      = optional(bool)
#     remote_debugging_version                      = optional(string)
#     runtime_scale_monitoring_enabled              = optional(bool)
#     scm_ip_restriction                            = optional(any)
#     scm_ip_restriction_default_action             = optional(string)
#     scm_minimum_tls_version                       = optional(string)
#     scm_use_main_ip_restriction                   = optional(bool)
#     use_32_bit_worker                             = optional(bool)
#     websockets_enabled                            = optional(bool)
#     worker_count                                  = optional(number)
#     application_stack                             = optional(any)
#   })
# }

variable "site_config" {
  description = "A map/object for the site_config block."
  type = any
  default = {}
  
}


####################################
# Linux Function App Variables
####################################

variable "storage_account_name" {
    description = "The name of the storage account used by the Function App."
    type        = string
    default     = null
}

variable "flex_consumption_function_app" {
    description = "Should the Function App be a Flex Consumption Function App?"
    type        = bool
    default     = false
  
}

# variable "service_plan_sku" {
#   description = "The SKU of the service plan. Required if flex_consumption_function_app is true."
#   type        = string
#   default     = null
#   validation {
#     condition = (
#       var.flex_consumption_function_app == false || (var.flex_consumption_function_app == true && var.service_plan_sku == "FC1")
#     )
#     error_message = "When flex_consumption_function_app is true, service_plan_sku must be set to 'FC1'."
#   }
# }

variable "service_plan_sku" {
  description = "The SKU of the service plan. Required if flex_consumption_function_app is true."
  type        = string
  default     = null  
}


variable "LinuxFunction" {
  description = "Configuration for a Linux Function. Requires storage_account_name and application_stack."
  type = object({
    storage_account_name = string
    application_stack    = map(any)
  })
  default = {
    storage_account_name = null
    application_stack    = {}
  }
}

variable "FlexFunction" {
  description = "Configuration for a Flex Function. Requires storage_container_type, storage_container_endpoint, and storage_authentication_type."
  type = object({
    storage_container_type         = string
    storage_container_endpoint     = string
    storage_authentication_type    = string
  })
}


variable "test_dummy_var" {
  description = "dummy variable created not using"
  type = string
  default = "dummy"
  
}
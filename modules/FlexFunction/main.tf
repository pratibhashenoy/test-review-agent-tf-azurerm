# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = ">= 3.100.0"
#     }
#   }
# }

# provider "azurerm" {
#   features {}
# }

# Example with for_each instead of count

# resource "azurerm_function_app_flex_consumption" "function_app_flex" {
#   for_each = var.flex_consumption_function_app && var.service_plan_sku == "FC1" ? { "enabled" = true } : {}

#   name                                           = var.name
#   location                                       = var.location
#   resource_group_name                            = var.resource_group_name
#   service_plan_id                                = var.service_plan_id
#   # ... other attributes ...

#   lifecycle {
#     precondition {
#       condition     = var.flex_consumption_function_app == false || var.service_plan_sku == "FC1"
#       error_message = "When flex_consumption_function_app is true, service_plan_sku must be 'FC1'."
#     }
#   }
# }


resource "azurerm_linux_function_app" "function_app" {
  count = var.flex_consumption_function_app == false ? 1 : 0
    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name
    service_plan_id = var.service_plan_id
    #storage_account_name = var.storage_account_name
    storage_account_name = var.LinuxFunction.storage_account_name
    storage_account_access_key = var.storage_access_key
    site_config {
      
    }


  lifecycle {
    precondition {
      condition     = var.flex_consumption_function_app == false ? var.LinuxFunction != null : true
      error_message = "LinuxFunction variable must be set when flex_consumption_function_app is false."
    }
  }
}

# resource "azurerm_function_app_flex_consumption" "function_app_flex" {
#   count = var.flex_consumption_function_app && var.service_plan_sku == "FC1" ? 1 : 0
#   # ...existing code...

#   lifecycle {
#     precondition {
#       condition     = var.flex_consumption_function_app == true ? var.FlexFunction != null : true
#       error_message = "FlexFunction variable must be set when flex_consumption_function_app is true."
#     }
#     precondition {
#       condition     = var.flex_consumption_function_app == false || var.service_plan_sku == "FC1"
#       error_message = "When flex_consumption_function_app is true, service_plan_sku must be 'FC1'."
#     }
#   }
# }

# }


# NOTE: The Flex Consumption Function app requires AzureRM provider version >= 4.21.0
resource "azurerm_function_app_flex_consumption" "function_app_flex" {
    #count                                          = var.flex_consumption_function_app == true ? 1 : 0
  count = var.flex_consumption_function_app && var.service_plan_sku == "FC1" ? 1 : 0
  name                                           = var.name
  location                                       = var.location
  resource_group_name                            = var.resource_group_name
  service_plan_id                                = var.service_plan_id
  storage_container_type                         = var.storage_container_type
  storage_container_endpoint                     = var.storage_container_endpoint
  storage_authentication_type                    = var.storage_authentication_type
  runtime_name                                   = var.runtime_name
  runtime_version                                = var.runtime_version
  client_certificate_enabled                     = var.client_certificate_enabled
  client_certificate_exclusion_paths             = var.client_certificate_exclusion_paths
  client_certificate_mode                        = var.client_certificate_mode
  enabled                                        = var.enabled
  public_network_access_enabled                  = var.public_network_access_enabled
  storage_access_key                             = var.storage_access_key
  storage_user_assigned_identity_id              = var.storage_user_assigned_identity_id
  maximum_instance_count                         = var.maximum_instance_count
  instance_memory_in_mb                          = var.instance_memory_in_mb
  tags                                           = var.tags
  virtual_network_subnet_id                      = var.virtual_network_subnet_id
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  zip_deploy_file                                = var.zip_deploy_file

  app_settings = var.app_settings

  dynamic "auth_settings_v2" {
    for_each = var.auth_settings_v2 != null ? var.auth_settings_v2 : []
    content {
      auth_enabled                            = try(auth_settings_v2.value.auth_enabled, null)
      runtime_version                         = try(auth_settings_v2.value.runtime_version, null)
      config_file_path                        = try(auth_settings_v2.value.config_file_path, null)
      require_authentication                  = try(auth_settings_v2.value.require_authentication, null)
      unauthenticated_action                  = try(auth_settings_v2.value.unauthenticated_action, null)
      default_provider                        = try(auth_settings_v2.value.default_provider, null)
      excluded_paths                          = try(auth_settings_v2.value.excluded_paths, null)
      require_https                           = try(auth_settings_v2.value.require_https, null)
      http_route_api_prefix                   = try(auth_settings_v2.value.http_route_api_prefix, null)
      forward_proxy_convention                = try(auth_settings_v2.value.forward_proxy_convention, null)
      forward_proxy_custom_host_header_name   = try(auth_settings_v2.value.forward_proxy_custom_host_header_name, null)
      forward_proxy_custom_scheme_header_name = try(auth_settings_v2.value.forward_proxy_custom_scheme_header_name, null)

      dynamic "active_directory_v2" {
        for_each = try(auth_settings_v2.value.active_directory_v2, null) != null ? auth_settings_v2.value.active_directory_v2 : []
        content {
          client_id                            = try(active_directory_v2.value.client_id, null)
          tenant_auth_endpoint                 = try(active_directory_v2.value.tenant_auth_endpoint, null)
          client_secret_setting_name           = try(active_directory_v2.value.client_secret_setting_name, null)
          client_secret_certificate_thumbprint = try(active_directory_v2.value.client_secret_certificate_thumbprint, null)
          jwt_allowed_groups                   = try(active_directory_v2.value.jwt_allowed_groups, null)
          jwt_allowed_client_applications      = try(active_directory_v2.value.jwt_allowed_client_applications, null)
          www_authentication_disabled          = try(active_directory_v2.value.www_authentication_disabled, null)
          allowed_groups                       = try(active_directory_v2.value.allowed_groups, null)
          allowed_identities                   = try(active_directory_v2.value.allowed_identities, null)
          allowed_applications                 = try(active_directory_v2.value.allowed_applications, null)
          login_parameters                     = try(active_directory_v2.value.login_parameters, null)
          allowed_audiences                    = try(active_directory_v2.value.allowed_audiences, null)
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = try(auth_settings_v2.value.custom_oidc_v2, null) != null ? auth_settings_v2.value.custom_oidc_v2 : []
        content {
          name                          = try(custom_oidc_v2.value.name, null)
          client_id                     = try(custom_oidc_v2.value.client_id, null)
          openid_configuration_endpoint = try(custom_oidc_v2.value.openid_configuration_endpoint, null)
          name_claim_type               = try(custom_oidc_v2.value.name_claim_type, null)
          scopes                        = try(custom_oidc_v2.value.scopes, null)
          client_credential_method      = try(custom_oidc_v2.value.client_credential_method, null)
          client_secret_setting_name    = try(custom_oidc_v2.value.client_secret_setting_name, null)
          authorisation_endpoint        = try(custom_oidc_v2.value.authorisation_endpoint, null)
          token_endpoint                = try(custom_oidc_v2.value.token_endpoint, null)
          issuer_endpoint               = try(custom_oidc_v2.value.issuer_endpoint, null)
          certification_uri             = try(custom_oidc_v2.value.certification_uri, null)
        }
      }

      dynamic "login" {
        for_each = try(auth_settings_v2.value.login, null) != null ? [auth_settings_v2.value.login] : []
        content {
          logout_endpoint                   = try(login.value.logout_endpoint, null)
          token_store_enabled               = try(login.value.token_store_enabled, null)
          token_refresh_extension_time      = try(login.value.token_refresh_extension_time, null)
          token_store_path                  = try(login.value.token_store_path, null)
          token_store_sas_setting_name      = try(login.value.token_store_sas_setting_name, null)
          preserve_url_fragments_for_logins = try(login.value.preserve_url_fragments_for_logins, null)
          allowed_external_redirect_urls    = try(login.value.allowed_external_redirect_urls, null)
          cookie_expiration_convention      = try(login.value.cookie_expiration_convention, null)
          cookie_expiration_time            = try(login.value.cookie_expiration_time, null)
          validate_nonce                    = try(login.value.validate_nonce, null)
          nonce_expiration_time             = try(login.value.nonce_expiration_time, null)
        }
      }
    }
  }

  #   dynamic "client_certificate_exclusion_paths" {
  #     for_each = var.client_certificate_exclusion_paths != null ? [var.client_certificate_exclusion_paths] : []
  #     content {
  #       # Add your client_certificate_exclusion_paths attributes here
  #     }
  #   }

  dynamic "connection_string" {
    for_each = var.connection_string != null ? var.connection_string : []
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "sticky_settings" {
    for_each = var.sticky_settings_enabled == true ? [1] : []
    content {
      app_setting_names       = var.sticky.app_setting_names
      connection_string_names = var.sticky.connection_string_names
    }
  }

  dynamic "always_ready" {
    for_each = var.always_ready != null ? var.always_ready : []
    content {
      name           = always_ready.value.name
      instance_count = always_ready.value.instance_count
    }
  }

  site_config {
    # api_definition_url                            = var.site_config.api_definition_url
    # api_management_api_id                         = var.site_config.api_management_api_id
    # app_command_line                              = var.site_config.app_command_line
    # application_insights_connection_string        = var.site_config.application_insights_connection_string
    # application_insights_key                      = var.site_config.application_insights_key
    # app_service_logs                              = var.site_config.app_service_logs
    # container_registry_managed_identity_client_id = var.site_config.container_registry_managed_identity_client_id
    # container_registry_use_managed_identity       = var.site_config.container_registry_use_managed_identity
    # cors                                          = var.site_config.cors
    # default_documents                             = var.site_config.default_documents
    # health_check_path                             = var.site_config.health_check_path
    # health_check_eviction_time_in_min             = var.site_config.health_check_eviction_time_in_min
    # http2_enabled                                 = var.site_config.http2_enabled
    # ip_restriction                                = var.site_config.ip_restriction
    # ip_restriction_default_action                 = var.site_config.ip_restriction_default_action
    # load_balancing_mode                           = var.site_config.load_balancing_mode
    # managed_pipeline_mode                         = var.site_config.managed_pipeline_mode
    # minimum_tls_version                           = var.site_config.minimum_tls_version
    # remote_debugging_enabled                      = var.site_config.remote_debugging_enabled
    # remote_debugging_version                      = var.site_config.remote_debugging_version
    # runtime_scale_monitoring_enabled              = var.site_config.runtime_scale_monitoring_enabled
    # scm_ip_restriction                            = var.site_config.scm_ip_restriction
    # scm_ip_restriction_default_action             = var.site_config.scm_ip_restriction_default_action
    # scm_minimum_tls_version                       = var.site_config.scm_minimum_tls_version
    # scm_use_main_ip_restriction                   = var.site_config.scm_use_main_ip_restriction
    # use_32_bit_worker                             = var.site_config.use_32_bit_worker
    # websockets_enabled                            = var.site_config.websockets_enabled
    # worker_count                                  = var.site_config.worker_count
    # application_stack                             = var.site_config.application_stack

    dynamic "app_service_logs" {
      for_each = var.site_config.app_service_logs != null ? [var.site_config.app_service_logs] : []
      content {
        disk_quota_mb         = app_service_logs.value.disk_quota_mb
        retention_period_days = app_service_logs.value.retention_period_days
      }
    }
  }

    lifecycle {
    precondition {
      condition     = var.flex_consumption_function_app == false || var.service_plan_sku == "FC1"
      error_message = "When flex_consumption_function_app is true, service_plan_sku must be 'FC1'."
    }
  }
}
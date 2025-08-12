# GitHub Copilot Code Review Agent Instructions

## Project Overview
This repository contains modular Terraform code for deploying Azure resources, including:
- Resource Group
- Virtual Network and Subnet
- Storage Account
- Function App (Flex Consumption)
- Private Endpoint

Each resource is implemented as a separate module in the `modules/` directory.

## Code Review Guidelines

### General
- Ensure all Terraform resources follow Azure and Terraform best practices.
- Each module must have `main.tf`, `variables.tf`, `outputs.tf` and `README.md`.
- Each module must have 'README.md' file with usage examples and variable descriptions.
- All variables should have descriptions and types.
- Outputs should be meaningful and used for inter-module wiring.

### Storage Account Module
- Resource: `azurerm_storage_account`
- Confirm `public_network_access_enabled` is set as required (currently `false`).
- Validate required variables and secure defaults.

### Function App Module
- Resource: `azurerm_function_app_flex_consumption`
- Ensure `public_network_access_enabled` is set as required (currently `true`).
- Confirm correct use of `service_plan_id`, `runtime_name`, `runtime_version`, and storage settings.
- Validate the use of `azurerm_service_plan` with `sku_name = "FC1"`.

### Private Endpoint Module
- Resource: `azurerm_private_endpoint`
- Ensure all required attributes and variables are present.
- Confirm correct wiring to target resources.

### Virtual Network Module
- Resource: `azurerm_virtual_network` and `azurerm_subnet`
- Validate address space and subnet configuration.
- Ensure variables are used for all configurable values.

### Resource Group Module
- Resource: `azurerm_resource_group`
- Confirm variables for name and location.

### Flex Function
- Resource: `azurerm_function_app_flex_consumption`
- Ensure `public_network_access_enabled` is set as 'false'
- Confirm correct use of `service_plan_id`, `runtime_name`, `runtime_version`, and storage settings.
- Validate the use of `azurerm_service_plan` with `sku_name = "FC1"`.
- Ensure virtual network integration is enabled by default.
- Confirm 'webdeploy_publish_basic_authentication_enabled' is set as 'false'.
- Enforcing minimum TLS version 1.2.
- Requiring the 'identity' variable to be set as 'SystemAssigned'.
- Mandating a README.md with usage examples and variable descriptions.

## Security & Networking
- If public access is enabled, ensure it is justified and documented.
- If private endpoints are used, confirm that public access is restricted where appropriate.
- Check for any hardcoded secrets or sensitive values (should use variables or Azure Key Vault).

## Documentation
- Each module should have a `README.md` with usage examples and variable descriptions.
- The root should have an example of how to compose modules together.

## Output
- Provide actionable, concise feedback.
- Suggest improvements for security, maintainability, and Azure best practices.

---

_This file is intended for use by the GitHub Copilot code review agent. Update as your project evolves._

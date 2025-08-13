variable "name" {
  description = "The name of the private endpoint."
  type        = string
}

variable "location" {
  description = "The Azure location for the private endpoint."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the private endpoint."
  type        = string
}

variable "connection_name" {
  description = "The name of the private service connection."
  type        = string
}

variable "private_connection_resource_id" {
  description = "The resource ID of the resource to connect to."
  type        = string
}

variable "subresource_names" {
  description = "A list of subresource names."
  type        = list(string)
}

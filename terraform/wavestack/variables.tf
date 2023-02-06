variable "zuul_network_name" {
  type        = string
  description = "The name of the network that is created for zuul deployment"
  nullable    = false
}

variable "zuul_subnet_cidr" {
  type        = string
  description = "Defined CIDR for zuul"
  nullable    = false
}

variable "router_id" {
  type        = string
  description = "router the zuul network should be attached to"
  nullable    = false
}

variable "zuul_security_group" {
  type        = string
  description = "name of the security group that is about to be created"
  nullable    = false
}

variable "zuul_instance_image_id" {
  type        = string
  description = "image id used for the zuul instance"
  nullable    = false
}

variable "zuul_flavor_name" {
  type        = string
  description = "flavor name for the zuul instance"
  nullable    = false
}

variable "zuul_key_pair" {
  type        = string
  description = "key name for the zuul instance"
  nullable    = false
}

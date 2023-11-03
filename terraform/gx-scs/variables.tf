variable "zuul_network_name" {
  type        = string
  description = "The name of the network that is created for zuul deployment"
  nullable    = false
  default     = "zuul_network"
}

variable "zuul_subnet_cidr" {
  type        = string
  description = "Defined CIDR for zuul"
  nullable    = false
  default     = "192.168.199.0/24"
}

variable "router_id" {
  type        = string
  description = "router the zuul network should be attached to"
  nullable    = false
  default     = "96d4e5a0-4424-4dd5-8dac-ad8231b634f1"
}

variable "zuul_security_group" {
  type        = string
  description = "name of the security group that is about to be created"
  nullable    = false
  default     = "zuul_secgroup"
}

variable "zuul_instance_image_id" {
  type        = string
  description = "image id used for the zuul instance"
  nullable    = false
  default     = "a4a2cddf-6577-4e0c-b8e1-70ac584927df"
}

variable "zuul_flavor_name" {
  type        = string
  description = "flavor name for the zuul instance"
  nullable    = false
  default     = "SCS-8V-32"
}

variable "zuul_inital_ssh_pubkey" {
  type        = string
  description = "key name for the zuul instance"
  nullable    = false
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5TgWQ5ZKRkNd/We/laApQgresUqbJTABtQd2q0i/sMMHJJOSBzSW8EbC+4jTbbL4ui0GFfXfYwLHve0ZzMBL4cso5cKKv00GFRwHxyYE/ACiYzZDJLEo9uygvfELRUZF8/qRklJO4sIag2diR36vg6IYGsd+o/Z2a1WQS3SUCGzjHupG1bN+bLY7749q/s7WU22M5rnX61Qvu/0jDFxmpuxGb47fOWIUoGTAXA+OkUN3WZ0p1MXNJSHS9YY5XKZSeOQGcmj0htu9BVKa1UkBDEuxyh3PbY7qVf2NPDO0Y/a1TpTI6DKvYd3Km6HwXVy5GY84CauXr8X3GCye6wSL515eXs9xsaDHjVid+5AyCUr70jyYKOL6WIi058L2w+0pvZ3Ujn47TNnzhFuq65+Lx1J8ICjG4lMIWHvYcpBa7ec+4BbLsqAIi763an/v4rRum5FigMhd3di+ecvVliiIOj3p8zH5pmv+l6YzzN2ryypr3RoflVhRqjAi5SxeC2iBvpxlC1FDTKhLCprig7ZKr+mp17CFL+odhVG+3mSPISSeUDUVprqAb3Pem81mK4bkW6uQzgZOju8tHTfhh/N0SXHJLe3gol3fc4r2O4AWlZVsN12A3hHE0UXD8D+FrrCxtb/ssicc0AJn6/kVTWCSdRdvG2MaNzLMi34uBoKtp5Q== @o-otte"
}

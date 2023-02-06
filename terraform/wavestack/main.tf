# Define required providers
terraform {
  required_version = ">= 1.3.7"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.49.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  application_credential_id     = "e8b26493495a4f90aa1c379b2c9b65a2"
  application_credential_secret = "qwDjyb-c5cPTT3u-MRobaDnJyvulNiJTVeS8TQ1PwzpL5M2J4sII5v9mffmP-5LPRmkq9y89QafUZDOKTgN2qw"
  auth_url                      = "https://api.wavestack.de:5000"
  region                        = "MUC5"
}

module "zuul_infrastructure" {
  source                 = "../modules/zuul"
  zuul_network_name      = var.zuul_network_name
  zuul_subnet_cidr       = var.zuul_subnet_cidr
  router_id              = var.router_id
  zuul_security_group    = var.zuul_security_group
  zuul_instance_image_id = var.zuul_instance_image_id
  zuul_flavor_name       = var.zuul_flavor_name
  zuul_key_pair          = var.zuul_key_pair
}

output "floating_ip" {
  value = module.zuul_infrastructure.floating_ip
}

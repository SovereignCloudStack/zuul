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
  auth_url    = "https://api.wavestack.de:5000"
  region      = "MUC5"
}

module "zuul_infrastructure" {
    source = "../modules/zuul"
}

output "floating_ip" {
    value = module.zuul_infrastructure.floating_ip
}
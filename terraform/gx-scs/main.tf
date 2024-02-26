# Define required providers
terraform {
  required_version = ">= 1.3.7, <1.6.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# Configure the OpenStack Provider, set name of clouds.yaml entry according to your needs
provider "openstack" {
  cloud = var.zuul_cloudsyaml_identifier
}

provider "openstack" {
  alias = "dev"
  cloud = var.zuul_cloudsyaml_identifier_dev
}

resource "openstack_compute_keypair_v2" "inital_ssh_keypair" {
  name       = "zuul-initial"
  public_key = var.zuul_inital_ssh_pubkey
}

module "zuul_infrastructure" {
  source                 = "../modules/zuul"
  zuul_network_name      = var.zuul_network_name
  zuul_subnet_cidr       = var.zuul_subnet_cidr
  router_id              = var.router_id
  zuul_security_group    = var.zuul_security_group
  zuul_instance_image_id = var.zuul_instance_image_id
  zuul_flavor_name       = var.zuul_flavor_name
  zuul_key_pair          = openstack_compute_keypair_v2.inital_ssh_keypair.name
}

output "floating_ip" {
  value = module.zuul_infrastructure.floating_ip
}

module "zuul_infrastructure_dev" {
  providers = {
    openstack = openstack.dev
  }

  source                 = "../modules/zuul"
  zuul_vm_name           = "${var.zuul_vm_name}-dev"
  zuul_network_name      = var.zuul_network_name
  zuul_subnet_cidr       = var.zuul_subnet_cidr
  router_id              = var.router_id_dev
  zuul_security_group    = var.zuul_security_group
  zuul_instance_image_id = var.zuul_instance_image_id
  zuul_flavor_name       = var.zuul_flavor_name_dev
  zuul_key_pair          = openstack_compute_keypair_v2.inital_ssh_keypair.name
}

output "floating_ip_dev" {
  value = module.zuul_infrastructure_dev.floating_ip
}

# define terraform provider
terraform {
  required_version = ">= 1.3.7"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.49.0"
    }
  }
}

# create a network for zuul infrastructure
resource "openstack_networking_network_v2" "zuul_network" {
  name           = var.zuul_network_name
  admin_state_up = "true"
}

# create a IPv4 subnet used for zuul infrastructure
resource "openstack_networking_subnet_v2" "zuul_subnet" {
  name       = "zuul_subnet"
  network_id = openstack_networking_network_v2.zuul_network.id
  cidr       = var.zuul_subnet_cidr
  ip_version = 4
}

# add subnet to (pre existing) router
resource "openstack_networking_router_interface_v2" "int_1" {
  router_id = var.router_id
  subnet_id = openstack_networking_subnet_v2.zuul_subnet.id
}

# create seperate security group
resource "openstack_networking_secgroup_v2" "zuul_secgroup" {
  name        = var.zuul_security_group
  description = "zuul security group"
}

# open ssh port
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.zuul_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_gerrit_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.zuul_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_zuul_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9000
  port_range_max    = 9000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.zuul_secgroup.id
}

# create zuul head node
resource "openstack_compute_instance_v2" "zuul" {
  name            = "zuul"
  image_id        = var.zuul_instance_image_id
  flavor_name     = var.zuul_flavor_name
  key_pair        = var.zuul_key_pair
  security_groups = ["${openstack_networking_secgroup_v2.zuul_secgroup.id}"]

  network {
    name = openstack_networking_network_v2.zuul_network.name
  }
}

# create an floating IP 
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "external"
}

# attach floating IP to zuul instance
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.fip_1.address
  instance_id = openstack_compute_instance_v2.zuul.id
}

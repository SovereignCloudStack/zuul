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
  name           = "zuul_network"
  admin_state_up = "true"
}

# create a IPv4 subnet used for zuul infrastructure
resource "openstack_networking_subnet_v2" "zuul_subnet" {
  name       = "zuul_subnet"
  network_id = openstack_networking_network_v2.zuul_network.id
  cidr       = "192.168.199.0/24"
  ip_version = 4
}

# add subnet to (pre existing) router
resource "openstack_networking_router_interface_v2" "int_1" {
  router_id = "f3767ea8-9b83-4993-96e0-39affad7acf4"
  subnet_id = openstack_networking_subnet_v2.zuul_subnet.id
}

# create seperate security group
resource "openstack_networking_secgroup_v2" "zuul_secgroup" {
  name        = "zuul_secgroup"
  description = "My neutron security group"
}

# open ssh port
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.zuul_secgroup.id}"
}

# create zuul head node
resource "openstack_compute_instance_v2" "zuul" {
  name            = "zuul"
  image_id        = "f7aff0ef-5b69-42c1-844d-56f57db1e44b"
  flavor_name     = "SCS-4V:16:100s"
  key_pair        = "gonicus-bzapiec"
  security_groups = ["${openstack_networking_secgroup_v2.zuul_secgroup.id}"]

  network {
    name = "${openstack_networking_network_v2.zuul_network.name}"
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

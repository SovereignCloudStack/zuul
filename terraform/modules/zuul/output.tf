# printed associated floating IP
output "floating_ip" {
  description = "Floating IP for Zuul"
  value       = openstack_networking_floatingip_v2.fip_1.address
}
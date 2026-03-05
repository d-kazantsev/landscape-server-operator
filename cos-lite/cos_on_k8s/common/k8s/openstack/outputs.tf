output "subnet_id" {
  description = "ID of the k8s cluster subnet."
  value       = try(openstack_networking_subnet_v2.subnet[0].id, null)
}

// Network

locals {
  network_name = var.network_name != null ? var.network_name : "${var.cluster_name}-lb"
}

resource "openstack_networking_network_v2" "network" {
  count                 = var.subnet_cidr != null ? 1 : 0
  name                  = local.network_name
  admin_state_up        = true
  port_security_enabled = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  count      = var.subnet_cidr != null ? 1 : 0
  network_id = openstack_networking_network_v2.network[0].id

  ip_version = 4

  name            = local.network_name
  cidr            = var.subnet_cidr
  gateway_ip      = var.subnet_gw
  no_gateway      = var.no_gateway
  dns_nameservers = var.subnet_dns

  allocation_pool {
    start = var.subnet_allocation_pool_start != null ? var.subnet_allocation_pool_start : cidrhost(var.subnet_cidr, 2)
    end   = var.subnet_allocation_pool_end != null ? var.subnet_allocation_pool_end : cidrhost(var.subnet_cidr, -2)
  }
}

data "openstack_networking_router_v2" "router" {
  count = var.router_name != null ? 1 : 0
  name  = var.router_name
}

resource "openstack_networking_router_interface_v2" "router_interface_subnet" {
  count     = var.router_name != null ? 1 : 0
  router_id = data.openstack_networking_router_v2.router[0].id
  subnet_id = openstack_networking_subnet_v2.subnet[0].id
}

// Security groups
# Should be fixed once this is merged: https://github.com/charmed-kubernetes/charm-openstack-integrator/pull/13

resource "openstack_networking_secgroup_v2" "k8s_api_secgroup" {
  name        = "sg-k8s-api_${var.cluster_name}"
  description = "Security group allowing traffic to k8s API"
}

resource "openstack_networking_secgroup_rule_v2" "k8s_api_secgroup_rule_k8s" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.k8s_api_secgroup.id
}

resource "openstack_networking_secgroup_v2" "svc_secgroup" {
  name        = "sg-k8s-lb-svc_${var.cluster_name}"
  description = "Security group allowing traffic to Kubernetes LoadBalancer services"
}

resource "openstack_networking_secgroup_rule_v2" "svc_secgroup_rule_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 30000
  port_range_max    = 32767
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.svc_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "svc_secgroup_rule_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 30000
  port_range_max    = 32767
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.svc_secgroup.id
}

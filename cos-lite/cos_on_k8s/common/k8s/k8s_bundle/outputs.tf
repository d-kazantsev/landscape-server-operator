output "k8s_ctrl" {
  value = {
    app_name = module.k8s.app_name
    provides = module.k8s.provides
  }
}

output "k8s_worker" {
  value = {
    for k, w in module.k8s_worker : w.app_name => w.provides
  }
}

output "openstack_integration" {
  value = var.cloud_integration == "openstack" ? true : false
}

output "k8s_machines" {
  value = module.k8s.machines
}

output "k8s_worker_machines" {
  value = {
    for k, w in module.k8s_worker : w.app_name => w.machines
  }
}

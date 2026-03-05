
resource "juju_integration" "ceph_k8s_info" {
  model = var.model_name
  application {
    name     = var.k8s.app_name
    endpoint = var.k8s.provides.ceph_k8s_info
  }
  application {
    name     = juju_application.ceph_csi.name
    endpoint = "kubernetes-info"
  }
}

resource "juju_integration" "ceph_client" {
  model = var.model_name
  application {
    name     = juju_application.ceph_proxy.name
    endpoint = "client"
  }
  application {
    name     = juju_application.ceph_csi.name
    endpoint = "ceph-client"
  }
}
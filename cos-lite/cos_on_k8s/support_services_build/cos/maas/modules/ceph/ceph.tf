resource "juju_application" "ceph_proxy" {
  name  = "ceph-proxy"
  model = var.model_name

  charm {
    name    = "ceph-proxy"
    channel = var.channel
    base    = "ubuntu@22.04"
  }
  config = var.ceph_proxy_config
  machines = [var.ceph_proxy_id]
}

resource "juju_application" "ceph_csi" {
  name  = "ceph-csi"
  model = var.model_name

  charm {
    name    = "ceph-csi"
    channel = var.ceph_csi_channel
    base    = var.base
  }
  config = var.ceph_csi_config
}
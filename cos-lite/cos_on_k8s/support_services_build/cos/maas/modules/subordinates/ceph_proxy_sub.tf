resource "juju_application" "grafana_agent_ceph_proxy" {
  name  = "grafana-agent-ceph-proxy"
  model = var.model_name

  charm {
    name    = "grafana-agent"
    channel = "1/stable"
    base    = "ubuntu@22.04"
  }
  config = var.grafana_agent_vm_config
}

resource "juju_application" "landscape_client_ceph_proxy" {
  name  = "landscape-client-ceph-proxy"
  model = var.model_name

  charm {
    name    = "landscape-client"
    channel = "latest/stable"
    base    = "ubuntu@22.04"
  }
  config = var.landscape_client_config
}

resource "juju_application" "logrotated_ceph_proxy" {
  name  = "logrotated-ceph-proxy"
  model = var.model_name

  charm {
    name    = "logrotated"
    channel = "latest/stable"
    base    = "ubuntu@22.04"
  }
  config = var.logrotated_config
}

resource "juju_application" "ntp_ceph_proxy" {
  name  = "ntp-ceph-proxy"
  model = var.model_name

  charm {
    name    = "ntp"
    channel = "latest/stable"
    base    = "ubuntu@22.04"
  }
  config = var.ntp_config
}

resource "juju_application" "ubuntu_pro_ceph_proxy" {
  name  = "ubuntu-pro-ceph-proxy"
  model = var.model_name

  charm {
    name    = "ubuntu-advantage"
    channel = "latest/stable"
    base    = "ubuntu@22.04"
  }
  config = var.ubuntu_pro_config
}

resource "juju_integration" "grafana_agent_vm_ceph_proxy" {
  model = var.model_name
  application {
    name     = juju_application.grafana_agent_ceph_proxy.name
    endpoint = "juju-info"
  }
  application {
    name     = "ceph-proxy"
    endpoint = "juju-info"
  }
}

resource "juju_integration" "landscape_client_ceph_proxy" {
  model = var.model_name
  application {
    name     = juju_application.landscape_client_ceph_proxy.name
    endpoint = "container"
  }
  application {
    name     = "ceph-proxy"
    endpoint = "juju-info"
  }
}

resource "juju_integration" "logrotated_ceph_proxy" {
  model = var.model_name
  application {
    name     = juju_application.logrotated_ceph_proxy.name
    endpoint = "juju-info"
  }
  application {
    name     = "ceph-proxy"
    endpoint = "juju-info"
  }
}

resource "juju_integration" "ntp_ceph_proxy" {
  model = var.model_name
  application {
    name     = juju_application.ntp_ceph_proxy.name
    endpoint = "juju-info"
  }
  application {
    name     = "ceph-proxy"
    endpoint = "juju-info"
  }
}

resource "juju_integration" "ubuntu_pro_ceph_proxy" {
  model = var.model_name
  application {
    name     = juju_application.ubuntu_pro_ceph_proxy.name
    endpoint = "juju-info"
  }
  application {
    name     = "ceph-proxy"
    endpoint = "juju-info"
  }
}
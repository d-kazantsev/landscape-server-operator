resource "juju_integration" "grafana_agent_vm_loki" {
  model = var.model_name
  application {
    name     = "grafana-agent-vm"
    endpoint = "logging-consumer"
  }
  application {
    offer_url = var.saas_urls.loki
  }
}

resource "juju_integration" "grafana_agent_vm_prometheus" {
  model = var.model_name
  application {
    name     = "grafana-agent-vm"
    endpoint = "send-remote-write"
  }
  application {
    offer_url = var.saas_urls.prometheus
  }
}

resource "juju_integration" "grafana_agent_vm_dashboards" {
  model = var.model_name
  application {
    name     = "grafana-agent-vm"
    endpoint = "grafana-dashboards-provider"
  }
  application {
    offer_url = var.saas_urls.grafana
  }
}

resource "juju_integration" "grafana_agent_ceph_proxy_loki" {
  model = var.model_name
  application {
    name     = "grafana-agent-ceph-proxy"
    endpoint = "logging-consumer"
  }
  application {
    offer_url = var.saas_urls.loki
  }
}

resource "juju_integration" "grafana_agent_ceph_proxy_prometheus" {
  model = var.model_name
  application {
    name     = "grafana-agent-ceph-proxy"
    endpoint = "send-remote-write"
  }
  application {
    offer_url = var.saas_urls.prometheus
  }
}

resource "juju_integration" "grafana_agent_ceph_proxy_dashboards" {
  model = var.model_name
  application {
    name     = "grafana-agent-ceph-proxy"
    endpoint = "grafana-dashboards-provider"
  }
  application {
    offer_url = var.saas_urls.grafana
  }
}

resource "juju_integration" "grafana_agent_vm_k8s" {
  model = var.model_name
  application {
    name     = juju_application.grafana_agent_vm.name
    endpoint = "cos-agent"
  }
  application {
    name     = var.k8s.app_name
    endpoint = var.k8s.provides.cos_agent
  }
}

resource "juju_integration" "landscape_client_k8s" {
  model = var.model_name
  application {
    name     = juju_application.landscape_client.name
    endpoint = "container"
  }
  application {
    name     = var.k8s.app_name
    endpoint = "juju-info"
  }
}

resource "juju_integration" "logrotated_k8s" {
  model = var.model_name
  application {
    name     = juju_application.logrotated.name
    endpoint = "juju-info"
  }
  application {
    name     = var.k8s.app_name
    endpoint = "juju-info"
  }
}

resource "juju_integration" "ntp_k8s" {
  model = var.model_name
  application {
    name     = juju_application.ntp.name
    endpoint = "juju-info"
  }
  application {
    name     = var.k8s.app_name
    endpoint = "juju-info"
  }
}

resource "juju_integration" "ubuntu_pro_k8s" {
  model = var.model_name
  application {
    name     = juju_application.ubuntu_pro.name
    endpoint = "juju-info"
  }
  application {
    name     = var.k8s.app_name
    endpoint = "juju-info"
  }
}


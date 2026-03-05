resource "juju_integration" "logrotated_k8s" {
  model = var.model_name
  application {
    name     = juju_application.logrotated.name
    endpoint = "juju-info"
  }
  application {
    name     = var.k8s_ctrl.app_name
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
    name     = var.k8s_ctrl.app_name
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
    name     = var.k8s_ctrl.app_name
    endpoint = "juju-info"
  }
}

resource "juju_integration" "logrotated_k8s_worker" {
  model    = var.model_name
  for_each = var.k8s_worker
  application {
    name     = juju_application.logrotated.name
    endpoint = "juju-info"
  }
  application {
    name     = each.key
    endpoint = "juju-info"
  }
}

resource "juju_integration" "ntp_k8s_worker" {
  model    = var.model_name
  for_each = var.k8s_worker
  application {
    name     = juju_application.ntp.name
    endpoint = "juju-info"
  }
  application {
    name     = each.key
    endpoint = "juju-info"
  }
}

resource "juju_integration" "ubuntu_pro_k8s_worker" {
  model    = var.model_name
  for_each = var.k8s_worker
  application {
    name     = juju_application.ubuntu_pro.name
    endpoint = "juju-info"
  }
  application {
    name     = each.key
    endpoint = "juju-info"
  }
}

locals {
  base_names = {
    "ubuntu@24.04" = "noble"
    "ubuntu@22.04" = "jammy"
  }
}

resource "juju_integration" "grafana_agent_k8s" {
  model = var.model_name
  application {
    name     = juju_application.grafana_agent[local.base_names[var.base]].name
    endpoint = "cos-agent"
  }
  application {
    name     = var.k8s_ctrl.app_name
    endpoint = var.k8s_ctrl.provides.cos_agent
  }
}

resource "juju_integration" "grafana_agent_k8s_worker" {
  model    = var.model_name
  for_each = var.k8s_worker
  application {
    name     = juju_application.grafana_agent[local.base_names[var.base]].name
    endpoint = "cos-agent"
  }
  application {
    name     = each.key
    endpoint = each.value.cos_agent
  }
}

# TODO: should be update once openstack-integrator charm supports noble i.e. "name => juju_application.grafana_agent.name"
resource "juju_integration" "grafana_agent_openstack_integrator" {
  count = var.openstack_integration == true ? 1 : 0
  model = var.model_name
  application {
    name     = juju_application.grafana_agent["jammy"].name
    endpoint = "juju-info"
  }
  application {
    name     = "openstack-integrator"
    endpoint = "juju-info"
  }
}

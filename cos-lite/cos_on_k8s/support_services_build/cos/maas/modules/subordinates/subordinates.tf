resource "juju_application" "grafana_agent_vm" {
  name  = "grafana-agent-vm"
  model = var.model_name

  charm {
    name    = "grafana-agent"
    channel = var.grafana_channel
    base    = var.base
  }
  config = var.grafana_agent_vm_config
}

resource "juju_application" "landscape_client" {
  name  = "landscape-client"
  model = var.model_name

  charm {
    name    = "landscape-client"
    channel = var.channel
    base    = var.base
  }
  config = var.landscape_client_config
}

resource "juju_application" "logrotated" {
  name  = "logrotated"
  model = var.model_name

  charm {
    name    = "logrotated"
    channel = var.channel
    base    = var.base
  }
  config = var.logrotated_config
}

resource "juju_application" "ntp" {
  name  = "ntp"
  model = var.model_name

  charm {
    name    = "ntp"
    channel = "latest/beta"
    base    = var.base
  }
  config = var.ntp_config
}

resource "juju_application" "ubuntu_pro" {
  name  = "ubuntu-pro"
  model = var.model_name

  charm {
    name    = "ubuntu-advantage"
    channel = var.channel
    base    = var.base
  }
  config = var.ubuntu_pro_config
}

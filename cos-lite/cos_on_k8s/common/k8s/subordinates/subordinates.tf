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
    channel = var.ntp_channel
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

resource "juju_application" "grafana_agent" {
  for_each = var.grafana_agent_bases

  name  = "grafana-agent-${each.key}"
  model = var.model_name

  charm {
    name    = "grafana-agent"
    channel = var.channel
    base    = each.value
  }
  config = var.grafana_agent_config
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

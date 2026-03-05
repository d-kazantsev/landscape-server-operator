resource "juju_application" "alertmanager" {
  name  = "alertmanager"
  model = var.model_name

  charm {
    name    = var.alertmanager_charm_details.name
    channel = var.alertmanager_charm_details.channel
    base    = var.alertmanager_charm_details.base
  }

  config             = var.alertmanager_charm_details.config
  trust              = var.alertmanager_charm_details.trust
  storage_directives = var.alertmanager_charm_details.storage_directives
}

resource "juju_application" "blackbox_exporter" {
  name  = "blackbox-exporter"
  model = var.model_name

  charm {
    name    = var.blackbox_exporter_charm_details.name
    channel = var.blackbox_exporter_charm_details.channel
    base    = var.blackbox_exporter_charm_details.base
  }

  config = var.blackbox_exporter_charm_details.config
  trust  = var.blackbox_exporter_charm_details.trust
}

resource "juju_application" "catalogue" {
  name  = "catalogue"
  model = var.model_name

  charm {
    name    = var.catalogue_charm_details.name
    channel = var.catalogue_charm_details.channel
    base    = var.catalogue_charm_details.base
  }

  config = var.catalogue_charm_details.config
  trust  = var.catalogue_charm_details.trust
}

resource "juju_application" "grafana" {
  name  = "grafana"
  model = var.model_name

  charm {
    name    = var.grafana_charm_details.name
    channel = var.grafana_charm_details.channel
    base    = var.grafana_charm_details.base
  }

  config             = var.grafana_charm_details.config
  trust              = var.grafana_charm_details.trust
  storage_directives = var.grafana_charm_details.storage_directives
}

resource "juju_application" "loki" {
  name  = "loki"
  model = var.model_name

  charm {
    name    = var.loki_charm_details.name
    channel = var.loki_charm_details.channel
    base    = var.loki_charm_details.base
  }

  config             = var.loki_charm_details.config
  trust              = var.loki_charm_details.trust
  storage_directives = var.loki_charm_details.storage_directives
}

resource "juju_application" "prometheus" {
  name  = "prometheus"
  model = var.model_name

  charm {
    name    = var.prometheus_charm_details.name
    channel = var.prometheus_charm_details.channel
    base    = var.prometheus_charm_details.base
  }

  config             = var.prometheus_charm_details.config
  trust              = var.prometheus_charm_details.trust
  storage_directives = var.prometheus_charm_details.storage_directives
}

resource "juju_application" "scrape_interval_config_metrics" {
  name  = "scrape-interval-config-metrics"
  model = var.model_name

  charm {
    name    = var.scrape_interval_config_metrics_charm_details.name
    channel = var.scrape_interval_config_metrics_charm_details.channel
    base    = var.scrape_interval_config_metrics_charm_details.base
  }

  config = var.scrape_interval_config_metrics_charm_details.config
  trust  = var.scrape_interval_config_metrics_charm_details.trust
}

resource "juju_application" "scrape_interval_config_monitors" {
  name  = "scrape-interval-config-monitors"
  model = var.model_name

  charm {
    name    = var.scrape_interval_config_monitors_charm_details.name
    channel = var.scrape_interval_config_monitors_charm_details.channel
    base    = var.scrape_interval_config_monitors_charm_details.base
  }

  config = var.scrape_interval_config_monitors_charm_details.config
  trust  = var.scrape_interval_config_monitors_charm_details.trust
}

resource "juju_application" "traefik" {
  name  = "traefik"
  model = var.model_name

  charm {
    name    = var.traefik_charm_details.name
    channel = var.traefik_charm_details.channel
    base    = var.traefik_charm_details.base
  }

  config = var.traefik_charm_details.config
  trust  = var.traefik_charm_details.trust
}

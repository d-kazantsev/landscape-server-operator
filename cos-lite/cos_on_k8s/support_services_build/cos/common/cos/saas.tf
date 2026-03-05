resource "juju_offer" "alertmanager" {
  model            = var.model_name
  application_name = juju_application.alertmanager.name
  endpoints         = ["karma-dashboard"]
}

resource "juju_offer" "grafana" {
  model            = var.model_name
  application_name = juju_application.grafana.name
  endpoints         = ["grafana-dashboard"]
}

resource "juju_offer" "loki" {
  model            = var.model_name
  application_name = juju_application.loki.name
  endpoints         = ["logging"]
}

resource "juju_offer" "scrape_interval_config_metrics" {
  model            = var.model_name
  application_name = juju_application.scrape_interval_config_metrics.name
  endpoints         = ["configurable-scrape-jobs"]
}

resource "juju_offer" "scrape_interval_config_monitors" {
  model            = var.model_name
  application_name = juju_application.scrape_interval_config_monitors.name
  endpoints         = ["configurable-scrape-jobs"]
}

resource "juju_offer" "prometheus_metrics_remote_write" {
  name             = "prometheus"
  model            = var.model_name
  application_name = juju_application.prometheus.name
  endpoints         = ["metrics-endpoint", "receive-remote-write"]
}
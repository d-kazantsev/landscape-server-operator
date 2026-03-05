output "saas_urls" {
  value = {
    alertmanager                    = juju_offer.alertmanager.url
    grafana                         = juju_offer.grafana.url
    loki                            = juju_offer.loki.url
    prometheus                      = "admin/${var.model_name}.${juju_application.prometheus.name}"
    scrape_interval_config_metrics  = juju_offer.scrape_interval_config_metrics.url
    scrape_interval_config_monitors = juju_offer.scrape_interval_config_monitors.url
  }
}

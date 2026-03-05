resource "juju_integration" "traefik_prometheus" {
  model = var.model_name
  application {
    name     = juju_application.traefik.name
    endpoint = "ingress-per-unit"
  }
  application {
    name     = juju_application.prometheus.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "traefik_loki" {
  model = var.model_name
  application {
    name     = juju_application.traefik.name
    endpoint = "ingress-per-unit"
  }
  application {
    name     = juju_application.loki.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "traefik_grafana" {
  model = var.model_name
  application {
    name     = juju_application.traefik.name
    endpoint = "traefik-route"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "traefik_alertmanager" {
  model = var.model_name
  application {
    name     = juju_application.traefik.name
    endpoint = "ingress"
  }
  application {
    name     = juju_application.alertmanager.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "traefik_catalogue" {
  model = var.model_name
  application {
    name     = juju_application.traefik.name
    endpoint = "ingress"
  }
  application {
    name     = juju_application.catalogue.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "prometheus_alertmanager" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "alertmanager"
  }
  application {
    name     = juju_application.alertmanager.name
    endpoint = "alerting"
  }
}

resource "juju_integration" "prometheus_grafana" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "grafana-source"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-source"
  }
}

resource "juju_integration" "loki_grafana" {
  model = var.model_name
  application {
    name     = juju_application.loki.name
    endpoint = "grafana-source"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-source"
  }
}

resource "juju_integration" "alertmanager_grafana" {
  model = var.model_name
  application {
    name     = juju_application.alertmanager.name
    endpoint = "grafana-source"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-source"
  }
}

resource "juju_integration" "loki_alertmanager" {
  model = var.model_name
  application {
    name     = juju_application.loki.name
    endpoint = "alertmanager"
  }
  application {
    name     = juju_application.alertmanager.name
    endpoint = "alerting"
  }
}

resource "juju_integration" "traefik_prometheus_metrics" {
  model = var.model_name
  application {
    name     = juju_application.traefik.name
    endpoint = "metrics-endpoint"
  }
  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "prometheus_alertmanager_metrics" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
  application {
    name     = juju_application.alertmanager.name
    endpoint = "self-metrics-endpoint"
  }
}

resource "juju_integration" "prometheus_loki_metrics" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
  application {
    name     = juju_application.loki.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "prometheus_grafana_metrics" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "loki_grafana_dashboard" {
  model = var.model_name
  application {
    name     = juju_application.loki.name
    endpoint = "grafana-dashboard"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "prometheus_grafana_dashboard" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "grafana-dashboard"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "alertmanager_grafana_dashboard" {
  model = var.model_name
  application {
    name     = juju_application.alertmanager.name
    endpoint = "grafana-dashboard"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "blackbox_exporter_grafana_dashboard" {
  model = var.model_name
  application {
    name     = juju_application.blackbox_exporter.name
    endpoint = "grafana-dashboard"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "catalogue_grafana" {
  model = var.model_name
  application {
    name     = juju_application.catalogue.name
    endpoint = "catalogue"
  }
  application {
    name     = juju_application.grafana.name
    endpoint = "catalogue"
  }
}

resource "juju_integration" "catalogue_prometheus" {
  model = var.model_name
  application {
    name     = juju_application.catalogue.name
    endpoint = "catalogue"
  }
  application {
    name     = juju_application.prometheus.name
    endpoint = "catalogue"
  }
}

resource "juju_integration" "catalogue_alertmanager" {
  model = var.model_name
  application {
    name     = juju_application.catalogue.name
    endpoint = "catalogue"
  }
  application {
    name     = juju_application.alertmanager.name
    endpoint = "catalogue"
  }
}

resource "juju_integration" "prometheus_scrape_interval_config_metrics" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
  application {
    name     = juju_application.scrape_interval_config_metrics.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "prometheus_scrape_interval_config_monitors" {
  model = var.model_name
  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
  application {
    name     = juju_application.scrape_interval_config_monitors.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "blackbox_exporter_prometheus" {
  model = var.model_name
  application {
    name     = juju_application.blackbox_exporter.name
    endpoint = "self-metrics-endpoint"
  }
  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
}

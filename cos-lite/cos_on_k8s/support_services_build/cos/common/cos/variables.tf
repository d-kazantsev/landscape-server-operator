variable "model_name" {
  description = "The name of the Juju model where COS will be deployed"
  type        = string
  default     = "cos"
}

variable "alertmanager_charm_details" {
  description = "Alertmanager charm details"
  type = object({
    name               = string
    channel            = string
    base               = string
    trust              = bool
    storage_directives = map(string)
    config             = map(string)
  })
  default = {
    name    = "alertmanager-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = true
    storage_directives = {
      data = "20G"
    }
    config = {}
  }
}

/* example of alertmanager config with snmp notifier
  alertmanager_charm_details = {
    name    = "alertmanager-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = true
    storage_directives = {
      data = "20G"
    }
    config = {
      config_file = <<-EOF
        global:
          http_config:
            tls_config:
              insecure_skip_verify: true
        receivers:
        - name: snmp_notifier
          webhook_configs:
            - send_resolved: true  
              url: _input_value_
        route:
          group_by:
          - juju_application
          - juju_model_uuid
          - juju_model
          group_interval: 5m
          group_wait: 30s
          receiver: snmp_notifier
          repeat_interval: 1h
      EOF
    }
  }
*/

variable "blackbox_exporter_charm_details" {
  description = "Blackbox-Exporter charm details"
  type = object({
    name    = string
    channel = string
    base    = string
    trust   = bool
    config  = map(string)
  })
  default = {
    name     = "blackbox-exporter-k8s"
    channel  = "1/stable"
    revision = null
    base     = "ubuntu@22.04"
    trust    = true
    config = {
      config_file = <<-EOF
        modules:
          http_2xx:
            prober: http
            http:
              preferred_ip_protocol: ip4
              valid_status_codes: [200,400,401,404]
              tls_config:
                insecure_skip_verify: true
        EOF
      probes_file = <<-EOF
        scrape_configs:
        - job_name: 'blackbox-http-monitoring'
          metrics_path: /probe
          params:
            module: [http_2xx]
          static_configs:
          - targets:
            - https://landscape._input_url_
            - https://cos._input_url_/cos-catalogue/
            - https://ceph._input_public_url_:8443
            - https://keystone._input_public_url__:5000/v3
            - http://maas._input_url_/MAAS/
            - https://radosgw._input_public_url_:443/swift/v1
            - https://glance._input_public_url_:9292
            - https://manila._input_public_url_:8786/v2/
            - https://neutron._input_public_url_:9696
            - https://aodh._input_public_url_:8042
            - https://keystone._input_public_url_:5000/v3
            - https://octavia._input_public_url_:9876
            - https://manila._input_public_url_:8786/v2/
            - https://designate._input_public_url_:9001
            - https://masakari._input_public_url_:15868/v1/
            - https://heat._input_public_url_:8000/v1
            - https://nova._input_public_url_:8774/v2.1
            - https://magnum._input_public_url_:9511/v1
            - https://barbican._input_public_url_:9311
            - https://radosgw._input_public_url_:443/
            - https://watcher._input_public_url_:9322
            - https://gnocchi._input_public_url_:8041
            - https://placement._input_public_url_:8778
            - https://heat._input_public_url_:8004/v1/
            - https://cinder._input_public_url_:8776/v3/
      EOF
    }
  }
}

variable "catalogue_charm_details" {
  description = "Catalogue charm details"
  type = object({
    name    = string
    channel = string
    base    = string
    trust   = bool
    config  = map(string)
  })
  default = {
    name    = "catalogue-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = true
    config = {
      description = "Canonical Observability Stack Lite, or COS Lite, is a light-weight, highly-integrated, \nJuju-based observability suite running on Kubernetes.\n"
      tagline     = "Model-driven Observability Stack deployed with a single command."
      title       = "Canonical Observability Stack"
    }
  }
}

variable "grafana_charm_details" {
  description = "Grafana charm details"
  type = object({
    name               = string
    channel            = string
    base               = string
    trust              = bool
    storage_directives = map(string)
    config             = map(string)
  })
  default = {
    name    = "grafana-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = true
    storage_directives = {
      database = "20G"
    }
    config = {
      allow_embedding = "true"
    }
  }
}

variable "loki_charm_details" {
  description = "Loki charm details"
  type = object({
    name               = string
    channel            = string
    base               = string
    trust              = bool
    storage_directives = map(string)
    config             = map(string)
  })
  default = {
    name    = "loki-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = true
    storage_directives = {
      active-index-directory = "2G"
      loki-chunks            = "2000G"
    }
    config = {}
  }
}

variable "prometheus_charm_details" {
  description = "Prometheus charm details"
  type = object({
    name               = string
    channel            = string
    base               = string
    trust              = bool
    storage_directives = map(string)
    config             = map(string)
  })
  default = {
    name    = "prometheus-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = true
    storage_directives = {
      database = "2000G"
    }
    config = {}
  }
}

variable "scrape_interval_config_metrics_charm_details" {
  description = "scrape-interval-config-metrics charm details"
  type = object({
    name    = string
    channel = string
    base    = string
    trust   = bool
    config  = map(string)
  })
  default = {
    name    = "prometheus-scrape-config-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = false
    config = {
      scrape_interval = "15s"
      scrape_timeout  = "15s"
    }
  }
}

variable "scrape_interval_config_monitors_charm_details" {
  description = "scrape-interval-config-monitors charm details"
  type = object({
    name    = string
    channel = string
    base    = string
    trust   = bool
    config  = map(string)
  })
  default = {
    name    = "prometheus-scrape-config-k8s"
    channel = "1/stable"
    base    = "ubuntu@20.04"
    trust   = false
    config = {
      scrape_interval = "5m"
      scrape_timeout  = "30s"
    }
  }
}

variable "traefik_charm_details" {
  description = "Traefik charm details"
  type = object({
    name    = string
    channel = string
    base    = string
    trust   = bool
    config  = map(string)
  })
  default = {
    name    = "traefik-k8s"
    channel = "latest/stable"
    base    = "ubuntu@20.04"
    trust   = true
    config = {
      external_hostname = "_input_value_"
    }
  }
}

variable "model_name" {
  description = "The name of the Juju model to deploy the COS integrations to"
  type        = string
}

variable "saas_urls" {
  description = "COS SAAS URLs"
  type = object({
    alertmanager                    = string
    grafana                         = string
    loki                            = string
    prometheus                      = string
    scrape_interval_config_metrics  = string
    scrape_interval_config_monitors = string
  })
}

variable "model_name" {
  description = "The name of the Juju model to deploy the subordinate charms to"
  type        = string
}

variable "channel" {
  description = "The channel to use for the subordinate charms"
  type        = string
  default     = "latest/stable"
}

variable "base" {
  description = "The base to use for the subordinate charms"
  type        = string
  default     = "ubuntu@24.04"
}

variable "grafana_agent_vm_config" {
  type = map(string)
  default = {
    global_scrape_timeout    = "60s"
    tls_insecure_skip_verify = "true"
  }
}

variable "landscape_client_config" {
  type = map(string)
  default = {
    account-name                = "standalone"
    disable-unattended-upgrades = "true"
    ping-url                    = "input_value"
    registration-key            = "input_value"
    ssl-public-key              = <<-EOF
      input_value
    EOF
    url                         = "input_value"
  }
}

variable "logrotated_config" {
  type = map(string)
  default = {
    logrotate-retention = "60"
  }
}

variable "ntp_config" {
  type = map(string)
  default = {
    pools              = "input_value"
    source             = ""
    verify_ntp_servers = "true"
  }
}

variable "ubuntu_pro_config" {
  type = map(string)
  default = {
    token = "input_value"
  }
}

variable "k8s" {
  description = "Reference to k8s charm"
  type = object({
    app_name = string
    provides = map(string)
  })
}

variable grafana_channel {
  type        = string
  default     = "1/stable"
  description = "grafana channel"
}


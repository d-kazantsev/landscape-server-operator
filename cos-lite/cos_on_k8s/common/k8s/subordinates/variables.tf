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

variable "grafana_agent_config" {
  type = map(string)
  default = {
    global_scrape_timeout    = "60s"
    tls_insecure_skip_verify = "true"
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
    verify_ntp_servers = "true"
  }
}

variable "ubuntu_pro_config" {
  type    = map(string)
  default = null
}

variable "landscape_client_config" {
  type = map(string)
  default = {
    account-name                = "standalone"
    disable-unattended-upgrades = "true"
    # ping-url = "input_value"
    # registration-key = "input_value"
    # ssl-public-key = <<-EOF
    #   input_value
    # EOF
    # url = "input_value"
  }
}

variable "k8s_ctrl" {
  description = "Reference to k8s charm"
  type = object({
    app_name = string
    provides = map(string)
  })
}

# using a for_each in the integration resources allows us to accommodate a topology with converged control and worker roles i.e. k8s_worker would be an empty map.
variable "k8s_worker" {
  description = "Reference to k8s worker charm"
  type        = map(map(string))
  default     = null
}

# temporary until 24.04 support lands in latest/stable
variable "ntp_channel" {
  description = "The channel to use for the ntp charm"
  type        = string
  default     = "latest/beta"
}

variable "grafana_agent_bases" {
  description = "Map of bases to use for the grafana agent"
  type        = map(string)
  default = {
    "noble" = "ubuntu@24.04"
  }
}

variable "openstack_integration" {
  description = "Wheter this cluster is deployed with openstack integration"
  type        = bool
  default     = false
}

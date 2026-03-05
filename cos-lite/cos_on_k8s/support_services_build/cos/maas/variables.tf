variable "module_source" {
  description = "Whether the module source is local or remote"
  type        = string
  default     = "remote" # can be "local" or "remote"  
}

variable "juju_controller_name" {
  description = "Name of the existing Juju controller onto which the k8s cloud will be added"
  type        = string
}

variable "model_name" {
  description = "The name of the Juju model to deploy the Kubernetes cluster to"
  type        = string
  default     = "k8s-cos"
}

variable "cloud_name" {
  description = "The name of the cloud to deploy the Kubernetes cluster to"
  type        = string
}

variable "credential_name" {
  description = "The name of the Juju credential to use for the model"
  type        = string
  default     = null
}

variable "model_config" {
  description = "Juju model config for COS"
  type        = map(string)
  default     = null
}

variable "landscape_client_config" {
  type    = map(string)
  default = null
}

variable "ntp_config" {
  type    = map(string)
  default = null
}

variable "ubuntu_pro_config" {
  type    = map(string)
  default = null
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
}

variable "blackbox_exporter_charm_details" {
  description = "Blackbox-Exporter charm details"
  type = object({
    name    = string
    channel = string
    base    = string
    trust   = bool
    config  = map(string)
  })
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
}

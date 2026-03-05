variable "user" {
  description = "User who is installing juju"
  type        = string
}

variable "cloud_name" {
  description = "Cloud name"
  type        = string
}

variable "agent_version" {
  description = "juju agent version to use"
  type        = string
  default     = null
}

variable "controller_charm_path" {
  description = "Path to locally stored controller charm"
  type        = string
  default     = null
}

variable "bootstrap_constraints" {
  description = "Boostrap constraints"
  type        = string
  default     = null
}

variable "controller_model_config_details" {
  description = "Details for model-config.yaml either generate from variables or use explicit file"
  type = object({
    path                 = optional(string) # you can pass a path to a config file
    template_path        = optional(string) # or you can pass a path to a template file which will be rendered using the variables below
    airgapped            = optional(bool)
    juju_agents_key_path = optional(string)
    cis_hardening_level  = optional(string)
    esm_cis_key_path     = optional(string)
    esm_infra_key_path   = optional(string)
    pro_token            = optional(string)
    contract_server_url  = optional(string)
    local_host_file      = optional(bool)
    pcr_ip_address       = optional(string)
    domain               = optional(string)
    ca_cert_path         = optional(string)
    lxd_snap_channel     = optional(string)
    snap_store_proxy_id  = optional(string)
    snap_assertions_path = optional(string)
  })
  default = {} # or you don't pass anything
}

variable "model_defaults_details" {
  description = "Details for model-defaults.yaml either generate from variables or use explicit file"
  type = object({
    path                 = optional(string) # you can pass a path to a config file
    template_path        = optional(string) # or you can pass a path to a template file which will be rendered using the variables below
    airgapped            = optional(bool)
    juju_agents_key_path = optional(string)
    cis_hardening_level  = optional(string)
    esm_cis_key_path     = optional(string)
    esm_infra_key_path   = optional(string)
    pro_token            = optional(string)
    contract_server_url  = optional(string)
    local_host_file      = optional(bool)
    pcr_ip_address       = optional(string)
    domain               = optional(string)
    ca_cert_path         = optional(string)
    lxd_snap_channel     = optional(string)
    snap_store_proxy_id  = optional(string)
    snap_assertions_path = optional(string)
  })
  default = {} # or you don't pass anything
}

variable "controller_details" {
  description = "Details of the bootstrapped controller"
  type = object({
    name  = string
    count = number
  })
}

variable "controller_cert_path" {
  description = "Path to location where the juju controller cert will be saved"
  type        = string
}

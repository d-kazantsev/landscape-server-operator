variable "cloud_name" {
  description = "Name of the juju cloud"
  type        = string
}

variable "storage" {
  description = "Storage class name"
  type        = string
  default     = null
}

variable "kubeconfig_details" {
  description = "Details of the kubeconfig file"
  type = object({
    path     = string
    context  = optional(string, null)
    cluster  = optional(string, null)
  })
}

variable "existing_controller" {
  description = "Controller where cloud should be added"
  type        = string
  default     = null
}

# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "manifest_yaml" {
  description = "Absolute path to the manifest yaml file for the charm configurations."
  type        = string
}

variable "cloud_integration" {
  description = "Selection of a cloud integration."
  type        = string
  default     = ""
  nullable    = false

  validation {
    condition     = can(regex("^(|openstack)$", var.cloud_integration))
    error_message = "Cloud integration must be one of: '', openstack."
  }
}

variable "csi_integration" {
  description = "Selection of a csi integration"
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for v in var.csi_integration : can(regex("^(|ceph)$", v))
    ])
    error_message = "Each item in 'csi_integration' must be either '' or 'ceph'."
  }
}

variable "model_name" {
  description = "Name of the Juju model to deploy to."
  type        = string
}

variable "octavia_subnet_id" {
  description = "ID of the subnet for Octavia."
  type        = string
  default     = null
}

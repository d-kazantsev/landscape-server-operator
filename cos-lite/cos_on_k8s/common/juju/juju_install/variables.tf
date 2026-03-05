variable "channel" {
  description = "juju channel"
  type        = string
  default     = "3/stable"
}

variable "uninstall_destroy" {
  description = "whether to uninstall juju on destroy"
  type        = bool
  default     = false
}

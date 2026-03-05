variable "model_name" {
  description = "The name of the Juju model to deploy the Kubernetes cluster to"
  type        = string
}

variable "spaces" {
  description = "Map of spaces<->cidrs to be added to the model"
  type        = map(string)
  default     = null
}

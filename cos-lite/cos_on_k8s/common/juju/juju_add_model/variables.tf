variable "model_name" {
  description = "The name of the Juju model to deploy the Kubernetes cluster to"
  type        = string
  default     = "my-model"
}

variable "cloud_name" {
  description = "The name of the cloud to deploy the Kubernetes cluster to"
  type        = string
  default     = "maas_cloud"
}

variable "credential_name" {
  description = "The name of the Juju credential to use for the model"
  type        = string
  default     = null
}

variable "model_config" {
  description = "The configuration for the Juju model"
  type        = map(string)
  default     = null
}

/* Example of model_config
  model_config = {
    default-base = "ubuntu@22.04"
    lxd-snap-channel: "5.0/stable"
    cloudinit-userdata = <<EOT
#cloud-config

  ca-certs:
    trusted:
    - |
      -----BEGIN CERTIFICATE-----
      ROOT CA
      -----END CERTIFICATE-----
      -----BEGIN CERTIFICATE-----
      INTERMEDIATE CA
      -----END CERTIFICATE-----
EOT
  }
*/

variable "path_to_ssh_key" {
  description = "The path to the SSH key to use for the model"
  type        = string
  default     = "/home/ubuntu/.ssh/id_rsa.pub" # set to null if creating a k8s cloud as ssh key is not needed in that scenario
}

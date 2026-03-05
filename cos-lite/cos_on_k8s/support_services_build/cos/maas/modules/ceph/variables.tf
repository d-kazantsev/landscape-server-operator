variable "model_name" {
  description = "The name of the Juju model to deploy the Kubernetes cluster to"
  type        = string
  default     = "k8s-cos"
}

variable "channel" {
  description = "The channel to use for the Ceph charms"
  type        = string
  default     = "squid/stable"
}

variable "base" {
  description = "The base to use for the Ceph charms"
  type        = string
  default     = "ubuntu@24.04"
}

variable "ceph_proxy_config" {
  description = "Ceph proxy charm config"
  type        = map(string)
  default = {
    fsid = "925ca119-0b80-4f7f-87bc-5446b2302dd9"
    admin-key = "AQBZ3RBoyqkTOBAAXK6Gzw85nzzt/c54Ghhleg=="
    monitor-hosts = "10.160.180.4,10.160.180.2,10.160.180.3"

  }
}

variable "ceph_csi_channel" {
  description = "The channel to use for the Ceph CSI charms"
  type        = string
  default     = "1.32/edge"
}

variable "ceph_csi_config" {
  description = "Ceph CSI charm config"
  type        = map(string)
  default = {
    release   = "v3.13.0"
    namespace = "kube-system"
  }
}

variable "ceph_csi_base" {
  description = "The base to use for the ceph-csi charms"
  type        = string
  default     = "ubuntu@24.04"
}


variable "k8s" {
  description = "Reference to k8s charm"
  type = object({
    app_name = string
    provides = map(string)
  })
}

variable ceph_proxy_id {
  type        = string
  description = "Machine ID"
}


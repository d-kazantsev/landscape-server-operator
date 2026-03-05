variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "network_name" {
  description = "Network name"
  type        = string
  default     = null
}

variable "subnet_cidr" {
  description = "Base CIDR for the subnet, e.g. 192.168.100.0/24"
  type        = string
  default     = null
}

variable "subnet_dns" {
  description = "DNS server for the subnet, e.g. 10.89.245.10"
  type        = list(string)
  default     = null
}

variable "subnet_gw" {
  description = "Gateway IP for the subnet"
  type        = string
  default     = null
}

variable "no_gateway" {
  description = "Disable gateway on the subnet"
  type        = bool
  default     = null
}

variable "subnet_pool" {
  description = "Subnet pool for the subnet"
  type        = string
  default     = null
}

variable "subnet_allocation_pool_start" {
  description = "Allocation pool start IP for the subnet"
  type        = string
  default     = null
}

variable "subnet_allocation_pool_end" {
  description = "Allocation pool end IP for the subnet"
  type        = string
  default     = null
}

variable "router_name" {
  description = "Router name"
  type        = string
  default     = null
}

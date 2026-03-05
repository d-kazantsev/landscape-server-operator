variable "temp_juju_yaml_dir" {
  description = "Temporary location of the juju yaml files"
  type        = string
  default     = "."
}

variable "existing_controller" {
  description = "Juju controller where cloud should be added if any"
  type        = string
  default     = null
}

variable "cloud_details" {
  description = "Details required to add a new cloud"
  type = object({
    type             = string                      # one of "lxd", "maas", "vsphere", "openstack"
    name             = string                      # for use with all clouds e.g. "ob68-maas"
    region           = optional(string, "default") # for use with all clouds e.g. regionOne
    protocol         = optional(string)            # for use with lxd, maas and openstack clouds e.g. "https" or "http"
    hostname         = optional(string)            # for use with all clouds e.g. "maas.example.com"
    port             = optional(string)            # for use with lxd, maas and openstack clouds e.g. "5240"
    client_cert      = optional(string)            # for use with lxd cloud i.e. path to cert file
    client_key       = optional(string)            # for use with lxd cloud i.e. path to cert key file
    server_cert      = optional(string)            # for use with lxd or openstack clouds i.e. path to cert file
    api_key          = optional(string)            # for use with maas cloud
    user             = optional(string)            # for use with vsphere or openstack (access_key) clouds e.g. "abcd"
    password         = optional(string)            # for use with vsphere or openstack (secret_key) clouds e.g. "abcd1234"
    folder           = optional(string)            # for use with vsphere cloud e.g. "dept1/user_1"
    tenant_id        = optional(string)            # for use with openstack cloud e.g. "35e408ed281646459ceaff8d31ea3ce3"
    user_domain_name = optional(string)            # for use with openstack cloud e.g. "default"
  })
}

/* === lxd Example
cloud_details = {
  type        = "lxd"
  name        = "lxd-cloud"
  protocol    = "https"
  hostname    = "localhost"
  port        = "8443"
  client_cert = "/tmp/client.crt"
  client_key  = "/tmp/client.key"
  server_cert = "/tmp/server.crt"
}
*/

/* === maas Example
cloud_details = {
  type        = "maas"
  name        = "maas-cloud"
  protocol    = "http"
  hostname    = "172.27.40.1"
  port        = "5240"
  api_key     = "SkxeMGU2fW9rwnrsNC:CLESdjU2E3prgmRB76:GvynqrV8vPt7aPemnqLAjw3dsUQ55d4L"
}
*/

/* === openstack Example
cloud_details = {
  type             = "openstack"
  name             = "openstack-cloud"
  region           = "regionOne"
  protocol         = "https"
  hostname         = "keystone.example.com"
  port             = "5000"
  server_cert      = "/tmp/ca.crt"
  user             = "e9fd8325c9344b0398eaec61090a1007"
  password         = "Xd7kjmMw-BaPOm8kO-giEPBHK_4-quf0q47Q"
  tenant_id        = "35e408ed281646459ceaff8d31ea3ce3"
  user_domain_name = "default"
}
*/

/* === vsphere Example
cloud_details = {
  type        = "vsphere"
  name        = "vsphere-cloud"
  region      = "vsphere-region"
  hostname    = "vsphere.example.com"
  user        = "user_1"
  password    = "pass123"
  folder      = "dept1/user_1"
}
*/

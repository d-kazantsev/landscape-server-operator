resource "juju_machine" "machine1" {
  model       = var.model_name
  base        = "ubuntu@24.04"
  name        = "k8s-1"
  constraints = "cores=8 mem=32G virt-type=virtual-machine"
}

resource "juju_machine" "machine2" {
  model       = var.model_name
  base        = "ubuntu@24.04"
  name        = "k8s-2"
  constraints = "cores=8 mem=32G virt-type=virtual-machine"
}

resource "juju_machine" "machine3" {
  model       = var.model_name
  base        = "ubuntu@24.04"
  name        = "k8s-3"
  constraints = "cores=8 mem=32G virt-type=virtual-machine"
}

resource "juju_machine" "machine4" {
  model       = var.model_name
  base        = "ubuntu@22.04"
  name        = "ceph-proxy"
  constraints = "cores=2 mem=8G virt-type=virtual-machine"
  depends_on = [juju_machine.machine1, juju_machine.machine2, juju_machine.machine3]
}

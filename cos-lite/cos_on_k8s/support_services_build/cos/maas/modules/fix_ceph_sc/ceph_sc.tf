resource "terraform_data" "fix_ceph_sc" {
  provisioner "local-exec" {
    command = <<-EOT
      juju ssh -m $MODEL 0 -- "sudo k8s kubectl get sc ceph-ext4 -o yaml | sed 's/reclaimPolicy: Delete/reclaimPolicy: Retain/' | sudo k8s kubectl replace --force -f -"
      juju ssh -m $MODEL 0 -- "sudo k8s kubectl get sc ceph-xfs -o yaml | sed 's/reclaimPolicy: Delete/reclaimPolicy: Retain/' | sudo k8s kubectl replace --force -f -"
    EOT
    environment = {
      MODEL = var.model_name
    }
  }
}

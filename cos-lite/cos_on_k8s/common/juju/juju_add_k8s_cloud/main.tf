resource "terraform_data" "juju_add_k8s_cloud" {

  input = {
    path       = var.kubeconfig_details.path
    cloud_name = var.cloud_name
    storage    = var.storage == null ? "" : "--storage=${var.storage}"
    context    = var.kubeconfig_details.context == null ? "" : "--context-name=${var.kubeconfig_details.context}"
    cluster    = var.kubeconfig_details.cluster == null ? "" : "--cluster-name=${var.kubeconfig_details.cluster}"
    controller = var.existing_controller == null ? "" : "--controller=${var.existing_controller}"
  }

  provisioner "local-exec" {
    command = "KUBECONFIG=$KUBECONFIG_PATH juju add-k8s $CLOUD_NAME $STORAGE $CONTEXT $CLUSTER $CONTROLLER --client"
    environment = {
      KUBECONFIG_PATH = self.input.path
      CLOUD_NAME      = self.input.cloud_name
      STORAGE         = self.input.storage
      CONTEXT         = self.input.context
      CLUSTER         = self.input.cluster
      CONTROLLER      = self.input.controller
    }
    when = create
  }
  provisioner "local-exec" {
    command = <<-EOT
      # make sure all models on k8s cloud are gone before removing the cloud
      for i in $(juju models --format json | jq -r --arg CLOUD "$CLOUD" '.models[] | select(.cloud == $CLOUD and .status.current != "destroying") | .name'); do juju destroy-model $i --destroy-storage --force --no-wait --no-prompt; done
      while juju models --format json | jq -r --arg CLOUD "$CLOUD" '.models[] | select(.cloud == $CLOUD and .status.current == "destroying")' 2>/dev/null | grep -q .; do sleep 60; done
      juju remove-k8s $CLOUD --client $CONTROLLER
    EOT
    environment = {
      CLOUD      = self.input.cloud_name
      CONTROLLER = self.input.controller
    }
    when = destroy
  }
}

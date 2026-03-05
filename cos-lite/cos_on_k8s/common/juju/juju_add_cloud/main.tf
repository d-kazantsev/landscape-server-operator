resource "local_file" "clouds_yaml" {
  content  = templatefile("${path.module}/cloud_templates/${var.cloud_details["type"]}/clouds.tftpl", var.cloud_details)
  filename = "${var.temp_juju_yaml_dir}/cloud.yaml"
}

resource "local_file" "credentials_yaml" {
  content  = templatefile("${path.module}/cloud_templates/${var.cloud_details["type"]}/credentials.tftpl", var.cloud_details)
  filename = "${var.temp_juju_yaml_dir}/credentials.yaml"
}

resource "terraform_data" "juju_add_cloud" {
  depends_on = [
    local_file.clouds_yaml,
    local_file.credentials_yaml
  ]

  input = {
    cloud_name      = var.cloud_details["name"]
    cloud_defn_yaml = "${var.temp_juju_yaml_dir}/cloud.yaml"
    controller      = var.existing_controller == null ? "" : "--controller=${var.existing_controller}"
    cred_yaml       = "${var.temp_juju_yaml_dir}/credentials.yaml"
    cred_name       = "${var.cloud_details["name"]}_cred"
  }

  provisioner "local-exec" {
    command = <<-EOT
      juju add-cloud $CLOUD_NAME $CLOUD_DEFN_YAML --client $CONTROLLER  --force # TODO: not sure this is needed --credential $CLOUD_CRED
      juju add-credential -f $CRED_YAML $CLOUD_NAME --client $CONTROLLER
    EOT
    environment = {
      CLOUD_NAME      = self.input.cloud_name
      CLOUD_DEFN_YAML = self.input.cloud_defn_yaml
      CRED_YAML       = self.input.cred_yaml
      CONTROLLER      = self.input.controller
    }
    when = create
  }
  provisioner "local-exec" {
    command = <<-EOT
      juju remove-credential $CLOUD_NAME $CRED_NAME --client $CONTROLLER
      juju remove-cloud $CLOUD_NAME --client $CONTROLLER
      rm $CLOUD_DEFN_YAML $CRED_YAML
    EOT
    environment = {
      CLOUD_NAME      = self.input.cloud_name
      CRED_NAME       = self.input.cred_name
      CONTROLLER      = self.input.controller
      CLOUD_DEFN_YAML = self.input.cloud_defn_yaml
      CRED_YAML       = self.input.cred_yaml
    }
    when = destroy
  }
}

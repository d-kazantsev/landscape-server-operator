resource "local_file" "controller_model_config_from_template" {
  count = var.controller_model_config_details.template_path != null ? 1 : 0

  content  = templatefile(var.controller_model_config_details.template_path, var.controller_model_config_details)
  filename = replace(var.controller_model_config_details.template_path, "tftpl", "yaml")
}

resource "local_file" "model_defaults_from_template" {
  count = var.model_defaults_details.template_path != null ? 1 : 0

  content  = templatefile(var.model_defaults_details.template_path, var.model_defaults_details)
  filename = replace(var.model_defaults_details.template_path, "tftpl", "yaml")
}

locals {
  charm_path    = var.controller_charm_path == null ? "" : "--controller-charm-path=${var.controller_charm_path}"
  agent_version = var.agent_version == null ? "" : "--agent-version=${var.agent_version}"
  constraints   = var.bootstrap_constraints == null ? "" : "--bootstrap-constraints=\"${var.bootstrap_constraints}\""

  model_config = (
    # First check if path is not null
    var.controller_model_config_details.path != null ? "--config=${var.controller_model_config_details.path}" :
    # Then check if template is not null
    var.controller_model_config_details.template_path != null ? "--config=${replace(var.controller_model_config_details.template_path, "tftpl", "yaml")}" :
    # Default case (both are null)
    ""
  )

  model_defaults = (
    # First check if path is not null
    var.model_defaults_details.path != null ? "--model-default=${var.model_defaults_details.path}" :
    # Then check if template is not null
    var.model_defaults_details.template_path != null ? "--model-default=${replace(var.model_defaults_details.template_path, "tftpl", "yaml")}" :
    # Default case (both are null)
    ""
  )

}

resource "terraform_data" "juju_bootstrap" {

  input = {
    controller_name = var.controller_details["name"]
  }

  provisioner "local-exec" {
    command = <<-EOT
      sleep 10
      juju --debug bootstrap ${local.constraints} $MODEL_CONFIG $MODEL_DEFAULTS $CHARM_PATH $AGENT_VERSION $CLOUD_NAME $CONTROLLER_NAME --credential $CRED_NAME
    EOT
    environment = {
      CLOUD_NAME      = var.cloud_name
      CONTROLLER_NAME = var.controller_details["name"]
      #CONSTRAINTS     = local.constraints # using $CONSTRAINTS in the command does not work, double-quotes are not rendered correctly, thus we use the local variable directly in the command
      CHARM_PATH     = local.charm_path
      MODEL_CONFIG   = local.model_config
      MODEL_DEFAULTS = local.model_defaults
      AGENT_VERSION  = local.agent_version
      CRED_NAME      = "${var.cloud_name}_cred"
    }
    when = create
  }

  provisioner "local-exec" {
    command = (var.controller_details["count"] > 1 ? "juju enable-ha -n $HA_COUNT" : "echo Juju HA is disabled. Skipping HA step")
    environment = {
      HA_COUNT = var.controller_details["count"]
    }
    when = create
  }

  provisioner "local-exec" {
    command = "juju kill-controller --no-prompt $CONTROLLER_NAME"
    environment = {
      CONTROLLER_NAME = self.input.controller_name
    }
    when = destroy
  }
}

data "local_file" "juju_accounts" {
  filename = "/home/${var.user}/.local/share/juju/accounts.yaml"
  depends_on = [
    terraform_data.juju_bootstrap
  ]
}

data "local_file" "juju_controllers" {
  filename = "/home/${var.user}/.local/share/juju/controllers.yaml"
  depends_on = [
    terraform_data.juju_bootstrap
  ]
}

resource "local_file" "controller_cert" {
  filename = "${var.controller_cert_path}/juju_controller.crt"
  content  = yamldecode(data.local_file.juju_controllers.content)["controllers"][var.controller_details["name"]]["ca-cert"]
}

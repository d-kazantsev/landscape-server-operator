resource "juju_model" "model" {
  name = var.model_name

  credential = var.credential_name
  cloud {
    name = var.cloud_name
  }

  config = var.model_config
}

resource "juju_ssh_key" "model_ssh_key" {
  count   = var.path_to_ssh_key != null ? 1 : 0 # if null, it means we are creating a k8s cloud in which case an ssh key is not needed
  model   = juju_model.model.name
  payload = trimspace(file(var.path_to_ssh_key))
}

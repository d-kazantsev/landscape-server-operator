resource "terraform_data" "juju_install" {

  input = {
    channel           = var.channel
    uninstall_destroy = var.uninstall_destroy
  }

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p /home/$USER/.local/share/juju
      # TODO: getting transient errors from snaptore when installing juju (error 408)
      bash -c '(r=5;while ! sudo snap install juju --channel=$CHANNEL ; do ((--r))||exit;sleep 5;done)'
    EOT
    environment = {
      CHANNEL = self.input.channel
    }
  }
  provisioner "local-exec" {
    command = <<-EOT
      if [ "$UNINSTALL" = "true" ]; then
        sudo snap remove juju --purge
        rm -rf "/home/$USER/.local/share/juju"
      fi
    EOT
    environment = {
      UNINSTALL = self.input.uninstall_destroy
    }
    when = destroy
  }
}

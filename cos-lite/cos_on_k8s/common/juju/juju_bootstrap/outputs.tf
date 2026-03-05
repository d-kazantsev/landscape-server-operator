output "juju_username" {
  value = yamldecode(data.local_file.juju_accounts.content)["controllers"][var.controller_details["name"]]["user"]
}

output "juju_password" {
  value     = yamldecode(data.local_file.juju_accounts.content)["controllers"][var.controller_details["name"]]["password"]
  sensitive = true
}

output "juju_controller_addresses" {
  value = join(",", yamldecode(data.local_file.juju_controllers.content)["controllers"][var.controller_details["name"]]["api-endpoints"])
}

output "juju_ca_cert_path" {
  value = var.controller_cert_path

  # The below approaches to pass the certificate content directly did not work with the juju provider
  # We therefore provide the path to the certificate as an output from this module

  # value = yamldecode(data.local_file.juju_controllers.content)["controllers"][var.juju_controller_name]["ca-cert"]
  # value = "-----BEGIN CERTIFICATE-----\n${replace(regex("-*\n([\\S\\s]*)\n-.*", yamldecode(data.local_file.juju_controllers.content)["controllers"][var.juju_controller_name]["ca-cert"])[0], "\n", "")}\n-----END CERTIFICATE-----"
  # value = "${replace(replace(replace(yamldecode(data.local_file.juju_controllers.content)["controllers"][var.juju_controller_name]["ca-cert"], "/-\n/", "-"), "/\n-/", "-"), "\n", "")}"
  # value = <<EOT
  #     yamldecode(data.local_file.juju_controllers.content)["controllers"][var.juju_controller_name]["ca-cert"]
  # EOT
}

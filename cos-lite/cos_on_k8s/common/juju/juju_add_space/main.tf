resource "terraform_data" "juju_add_space" {
  for_each = var.spaces

  input = {
    model_name = var.model_name
  }


  provisioner "local-exec" {
    command = <<-EOT
      juju add-space -m $MODEL $SPACE $CIDR
    EOT
    environment = {
      MODEL = self.input.model_name
      SPACE = each.key
      CIDR  = each.value
    }
    when = create
  }
}

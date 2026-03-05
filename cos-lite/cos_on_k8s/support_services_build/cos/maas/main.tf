module "juju_model" {
  source          = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform//common/juju/juju_add_model?ref=main" : "../../../common/juju/juju_add_model"
  model_name      = var.model_name
  cloud_name      = var.cloud_name
  credential_name = var.credential_name
  model_config    = var.model_config
  path_to_ssh_key = "/home/jujumanage/.ssh/id_ed25519.pub"
}

module "machines" {
  source                   = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform.git//support_services_build/cos/maas/modules/machines?ref=main" : "./modules/machines"
  model_name               = module.juju_model.model_name
}

# TODO: linked to this issue https://github.com/juju/terraform-provider-juju/issues/388
resource "terraform_data" "juju_wait_for_machines" {
  depends_on = [module.machines]
  provisioner "local-exec" {
    command = <<-EOT
      juju wait-for machine 0 -m $MODEL --timeout 3600s --query='(status=="started")'
      juju wait-for machine 1 -m $MODEL --timeout 3600s --query='(status=="started")'
      juju wait-for machine 2 -m $MODEL --timeout 3600s --query='(status=="started")'
      juju wait-for machine 3 -m $MODEL --timeout 3600s --query='(status=="started")'
    EOT
    environment = {
      MODEL = module.juju_model.model_name
    }
  }
}

module "k8s" {
  depends_on    = [terraform_data.juju_wait_for_machines]
  source        = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform//common/k8s/k8s_bundle?ref=main" : "../../../common/k8s/k8s_bundle"
  model_name    = module.juju_model.model_name
  manifest_yaml = "./manifest.yaml"
}

module "ceph" {
  depends_on   = [terraform_data.juju_wait_for_machines]
  source       = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform.git//support_services_build/cos/maas/modules/ceph?ref=main" : "./modules/ceph"
  model_name   = module.juju_model.model_name
  k8s          = module.k8s.k8s_ctrl
  ceph_proxy_id = module.machines.ceph_proxy_id
}

# TODO: linked to this issue https://github.com/juju/terraform-provider-juju/issues/388
resource "terraform_data" "juju_wait_for_k8s_ceph" {
  depends_on = [module.k8s, module.ceph]
  provisioner "local-exec" {
    command = <<-EOT
      juju wait-for model $MODEL --timeout 3600s --query='forEach(units, unit => (unit.workload-status == "active"))'
    EOT
    environment = {
      MODEL = module.juju_model.model_name
    }
  }
}

# hopefully this module disappears in the future once the ceph-csi charm allows the reclaim policy to be set through the charm
# https:.git//github.com/charmed-kubernetes/ceph-csi-operator/issues/44
module "fix_ceph_sc" {
  depends_on = [terraform_data.juju_wait_for_k8s_ceph]
  source     = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform.git//support_services_build/cos/maas/modules/fix_ceph_sc?ref=main" : "./modules/fix_ceph_sc"
  model_name = module.juju_model.model_name
}

resource "terraform_data" "fetch_kube_config" {
  depends_on = [module.fix_ceph_sc]
  provisioner "local-exec" {
    command = <<-EOT
      juju run -m $MODEL k8s/leader get-kubeconfig | yq eval '.kubeconfig' | tee $KUBE
    EOT
    environment = {
      MODEL = var.model_name
      KUBE  = "${path.module}/kubeconfig.yaml"
    }
  }
}

# TODO: linked to this issue https://github.com/juju/terraform-provider-juju/issues/671
module "juju_k8s_cloud" {
  depends_on = [terraform_data.fetch_kube_config]
  source     = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform//common/juju/juju_add_k8s_cloud?ref=main" : "../../../common/juju/juju_add_k8s_cloud"
  cloud_name = module.juju_model.model_name
  kubeconfig_details = {
    path = "${path.module}/kubeconfig.yaml"
  }
  existing_controller = var.juju_controller_name
}

module "juju_cos_model" {
  depends_on      = [module.juju_k8s_cloud]
  source          = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform//common/juju/juju_add_model?ref=main" : "../../../common/juju/juju_add_model"
  model_name      = "cos"
  cloud_name      = module.juju_model.model_name
  credential_name = module.juju_model.model_name
  path_to_ssh_key = null # k8s model don't support ssh keys
}

# TODO: replace with cos-ha module once cos-ha is ready for canonical-k8s
module "cos" {
  source                          = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform.git//support_services_build/cos/common/cos?ref=main" : "../../../support_services_build/cos/common/cos"
  model_name                      = module.juju_cos_model.model_name
  alertmanager_charm_details      = var.alertmanager_charm_details
  blackbox_exporter_charm_details = var.blackbox_exporter_charm_details
  loki_charm_details              = var.loki_charm_details
  prometheus_charm_details        = var.prometheus_charm_details
  traefik_charm_details           = var.traefik_charm_details
}

# TODO: linked to this issue https://github.com/juju/terraform-provider-juju/issues/388
resource "terraform_data" "juju_wait_for_cos" {
  depends_on = [module.cos]
  provisioner "local-exec" {
    command = <<-EOT
      juju wait-for model $MODEL --timeout 3600s --query='forEach(units, unit => (unit.workload-status == "active" || unit.workload-status == "blocked"))'
    EOT
    environment = {
      MODEL = module.juju_cos_model.model_name
    }
  }
}

module "subordinates" {
  depends_on              = [terraform_data.juju_wait_for_cos]
  source                  = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform.git//support_services_build/cos/maas/modules/subordinates?ref=main" : "./modules/subordinates/"
  model_name              = module.juju_model.model_name
  k8s                     = module.k8s.k8s_ctrl
  landscape_client_config = var.landscape_client_config
  ntp_config              = var.ntp_config
  ubuntu_pro_config       = var.ubuntu_pro_config
}

module "cos_integrations" {
  depends_on = [module.subordinates]
  source     = var.module_source == "remote" ? "github.com/canonical/field-moonshine-terraform.git//support_services_build/cos/maas/modules/cos_integrations?ref=main" : "./modules/cos_integrations"
  model_name = module.juju_model.model_name
  saas_urls  = module.cos.saas_urls
}

# TODO: linked to this issue https://github.com/juju/terraform-provider-juju/issues/388
resource "terraform_data" "juju_wait_end" {
  depends_on = [module.cos_integrations]
  provisioner "local-exec" {
    command = <<-EOT
      juju wait-for model $MODEL --timeout 3600s --query='forEach(units, unit => (unit.workload-status == "active" || unit.workload-status == "blocked"))'
    EOT
    environment = {
      MODEL = module.juju_model.model_name
    }
  }
}

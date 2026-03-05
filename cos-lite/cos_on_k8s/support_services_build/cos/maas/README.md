FCE
---
- execute maas:compose_vms step
- comment out the microk8s layer in project.yaml

Deploy
-----
Assumptions:
- juju client and controller are already present
- you've switched to the controller that will be used to host the k8s-cos model
```
sudo snap install opentofu --classic

# create terraform.tfvars file to set values for _INPUT_VALUE_ placeholders of variables.tf
# create manifest.yaml using manifest.yaml.example
tofu init
tofu apply
```

Notes
-----
- once [gh#44](https://github.com/charmed-kubernetes/ceph-csi-operator/issues/44) is fixed, we can get rid of the fix_ceph_sc module.

variable "gcloud_components" {
  default = ["kubectl", "beta"]
}

variable "platform" {
  default = "linux"
}

locals {
  gcloud_bin_path = "${path.module}/cache/${var.platform}/google-cloud-sdk/bin"
  gcloud = "${local.gcloud_bin_path}/gcloud"
}

resource "null_resource" "gcloud_components" {
  count = "${length(var.gcloud_components)}"

  triggers {
    components = "${join(",", var.gcloud_components)}"
  }

  provisioner "local-exec" {
    command = "${local.gcloud} components install ${local.components} -q"
  }
}

output "_triggers" {
  value = "${null_resource.gcloud_components.*.triggers}"
}

output "gcloud" {
  value = "${length(null_resource.gcloud_components.*.triggers) > 0 ? local.gcloud : local.gcloud}"
}

output "bq" {
  value = "${length(null_resource.gcloud_components.*.triggers) > 0 ? local.bq : local.bq}"
}

output "gsutil" {
  value = "${length(null_resource.gcloud_components.*.triggers) > 0 ? local.gsutil : local.gsutil}"
}

output "gcloud_bin_path" {
  value = "${length(null_resource.gcloud_components.*.triggers) > 0 ? local.gcloud_bin_path : local.gcloud_bin_path}"
}

variable "gcloud_components" {
  default = ["kubectl", "beta"]
}

variable "platform" {
  default = "linux"
}

locals {
  gcloud_bin_path = "${path.module}/cache/${var.platform}/google-cloud-sdk/bin"
  components = "${join(" ", var.gcloud_components)}"

  gcloud = "${local.gcloud_bin_path}/gcloud"
  gsutil = "${local.gcloud_bin_path}/gsutil"
  bq = "${local.gcloud_bin_path}/bq"
}

resource "null_resource" "gcloud_components" {
  triggers {
    components = "${md5(local.components)}"
  }

  provisioner "local-exec" {
    command = "${local.gcloud} components install ${local.components} -q"
  }
}

// output "hash" {
//   value = "${null_resource.gcloud_components.triggers.components}"
// }

output "gcloud" {
  value = "${length(null_resource.gcloud_components.triggers) > 0 ? local.gcloud : local.gcloud}"
}

output "bq" {
  value = "${length(null_resource.gcloud_components.triggers) > 0 ? local.bq : local.bq}"
}

output "gsutil" {
  value = "${length(null_resource.gcloud_components.triggers) > 0 ? local.gsutil : local.gsutil}"
}

output "gcloud_bin_path" {
  value = "${length(null_resource.gcloud_components.triggers) > 0 ? local.gcloud_bin_path : local.gcloud_bin_path}"
}

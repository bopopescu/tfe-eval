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
    command = "${local.gcloud} components install ${var.gcloud_components[count.index]} -q"
  }
}

output "_triggers" {
  value = "${null_resource.gcloud_components.*.triggers}"
}

output "gcloud" {
  value = "${local.gcloud}"
}

output "bq" {
  value = "${local.gcloud_bin_path}/bq"
}

output "gsutil" {
  value = "${local.gcloud_bin_path}/gsutil"
}

output "gcloud_bin_path" {
  value = "${local.gcloud_bin_path}"
}

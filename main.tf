variable "gcloud_sdk_version" {
  default = "232.0.0"
}

variable "gcloud_components" {
  default = ["kubectl", "beta"]
}

locals {
  gcloud_installer_script = "${path.module}/scripts/setup-gcloud.sh"
  components = "${join(" ", var.gcloud_components)}"
  gcloud_bin_path = "./google-cloud-sdk/bin"
  gcloud = "${local.gcloud_bin_path}/gcloud"
  bq = "${local.gcloud_bin_path}/bq"
  gsutil = "${local.gcloud_bin_path}/gsutil"
}

resource "null_resource" "gcloud_sdk" {
  triggers {
    // ALWAYS = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "${local.gcloud_installer_script}"
    environment {
      GCLOUD_SDK_VERSION = "${var.gcloud_sdk_version}"
    }
  }
}

resource "null_resource" "gcloud_components" {
  depends_on = ["null_resource.gcloud_sdk"]

  triggers {
    hash = "${md5(local.components)}"
  }

  provisioner "local-exec" {
    command = "${local.gcloud} components install ${local.components} -q"
  }
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

variable "gcloud_sdk_version" {
  default = "232.0.0"
}

variable "gcloud_components" {
  default = ["kubectl", "beta"]
}

locals {
  gcloud_bin_path = "${path.module}/google-cloud-sdk/bin"
  gcloud = "${local.gcloud_bin_path}/gcloud"
}

resource "null_resource" "gcloud_sdk" {
  triggers {
    GCLOUD_SDK_VERSION = "${var.gcloud_sdk_version}"
  }

  provisioner "local-exec" {
    command = "./scripts/setup-gcloud.sh"
    environment {
      GCLOUD_SDK_VERSION = "${var.gcloud_sdk_version}"
    }
  }
}

resource "null_resource" "gcloud_components" {
  count = "${length(var.gcloud_components)}"

  provisioner "local-exec" {
    command = "${local.gcloud} components install ${var.gcloud_components[count.index]}"
  }
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

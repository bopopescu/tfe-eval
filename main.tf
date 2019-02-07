variable "gcloud_sdk_version" {
  default = "232.0.0"
}

variable "gcloud_components" {
  default = ["kubectl", "beta"]
}

locals {
  gcloud_installer_script = "${path.module}/scripts/setup-gcloud.sh"
  gcloud_bin_path = "./google-cloud-sdk/bin"
  gcloud = "${local.gcloud_bin_path}/gcloud"
}

resource "null_resource" "gcloud_sdk" {
  triggers {
    ALWAYS = "${uuid()}"
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
  count = "${length(var.gcloud_components)}"

  triggers {
    ALWAYS = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "${local.gcloud} components install ${var.gcloud_components[count.index]} -q"
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

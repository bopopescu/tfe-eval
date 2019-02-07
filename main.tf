variable "google_cloud_sdk_version" {
  default = "232.0.0"
}

resource "null_resource" "google_cloud_sdk" {
  triggers {
    GOOGLE_CLOUD_SDK_VERSION = "${var.google_cloud_sdk_version}"
  }

  provisioner "local-exec" {
    command = "./scripts/setup-gcloud.sh"
    environment {
      GOOGLE_CLOUD_SDK_VERSION = "${var.google_cloud_sdk_version}"
    }
  }
}

output "gcloud" {
  value = "${path.module}/google-cloud-sdk/bin/gcloud"
}

output "bq" {
  value = "${path.module}/google-cloud-sdk/bin/bq"
}

output "gsutil" {
  value = "${path.module}/google-cloud-sdk/bin/gsutil"
}

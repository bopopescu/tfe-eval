resource "null_resource" "setup-gcloud" {
  triggers {
    _always_run = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "./scripts/setup-gcloud.sh"
  }
}

resource "null_resource" "gcloud-version" {
  depends_on = ["null_resource.setup-gcloud"]

  triggers {
    _always_run = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "./google-cloud-sdk/bin/gcloud --version"
  }
}

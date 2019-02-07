#! /usr/bin/env bash

set -e

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     OS_ARCH=linux;;
  Darwin*)    OS_ARCH=darwin;;
  *)          echo "Unknown platform: ${unameOut}" && exit 1
esac

echo $(pwd)
curl -sL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-${OS_ARCH}-x86_64.tar.gz | tar -xz
cat terraform.tfvars
cat zzz_backend_config.tf.json
echo $(ls ./google-cloud-sdk/bin)

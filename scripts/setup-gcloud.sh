#! /usr/bin/env bash

set -e

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     OS_ARCH=linux;;
  Darwin*)    OS_ARCH=darwin;;
  *)          echo "Unknown platform: ${unameOut}" && exit 1
esac

curl -sL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-${OS_ARCH}-x86_64.tar.gz | tar -xz

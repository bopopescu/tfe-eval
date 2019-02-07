.PHONY: gcloud.download gcloud.darwin gcloud.linux clean

GCLOUD_SDK_VERSION:=232.0.0
GCLOUD_SDK_URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-${OS_ARCH}-x86_64.tar.gz

all:
	$(MAKE) gcloud.darwin
	$(MAKE) gcloud.linux

gcloud.darwin: OS_ARCH=darwin
gcloud.darwin: gcloud.download

gcloud.linux: OS_ARCH=linux
gcloud.linux: gcloud.download

gcloud.download:
	mkdir -p cache/${OS_ARCH}/
	cd cache/${OS_ARCH}/ && \
		curl -sL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-${OS_ARCH}-x86_64.tar.gz | tar -xz

clean:
	rm -rf cache

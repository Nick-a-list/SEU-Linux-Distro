FROM --platform=linux/amd64 debian:trixie

RUN apt-get update && apt-get install -y --no-install-recommends \
    live-build \
    debootstrap \
    squashfs-tools \
    xorriso \
    syslinux \
    syslinux-utils \
    isolinux \
    grub-efi-amd64-bin \
    grub-pc-bin \
    mtools \
    dosfstools \
    ca-certificates \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
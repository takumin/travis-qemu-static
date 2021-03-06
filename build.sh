#!/bin/bash

set -eu

git clean -xdf
git submodule foreach git clean -xdf
git submodule foreach git submodule foreach git clean -xdf

BUILD_DIR="/tmp/qemu"
INSTALL_DIR="/opt/qemu"
QEMU_DIR="$(cd "$(dirname "$0")"; pwd)/qemu"

rm -fr "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"
pushd "${BUILD_DIR}"
"${QEMU_DIR}/configure" \
  --prefix="${INSTALL_DIR}" \
  --interp-prefix="${INSTALL_DIR}/gnemul" \
  --target-list=x86_64-softmmu \
  --static \
  --disable-system \
  --disable-user \
  --disable-linux-user \
  --disable-bsd-user \
  --disable-docs \
  --disable-guest-agent \
  --disable-guest-agent-msi \
  --disable-pie \
  --disable-modules \
  --disable-debug-tcg \
  --disable-debug-info \
  --disable-sparse \
  --disable-gnutls \
  --disable-nettle \
  --disable-gcrypt \
  --disable-auth-pam \
  --disable-sdl \
  --disable-gtk \
  --disable-vte \
  --disable-curses \
  --disable-vnc \
  --disable-vnc-sasl \
  --disable-vnc-jpeg \
  --disable-vnc-png \
  --disable-cocoa \
  --disable-virtfs \
  --disable-mpath \
  --disable-xen \
  --disable-xen-pci-passthrough \
  --disable-brlapi \
  --disable-curl \
  --disable-membarrier \
  --disable-fdt \
  --disable-bluez \
  --disable-kvm \
  --disable-hax \
  --disable-hvf \
  --disable-whpx \
  --disable-rdma \
  --disable-pvrdma \
  --disable-vde \
  --disable-netmap \
  --disable-linux-aio \
  --disable-cap-ng \
  --disable-attr \
  --disable-vhost-net \
  --disable-vhost-crypto \
  --disable-spice \
  --disable-rbd \
  --disable-libiscsi \
  --disable-libnfs \
  --disable-smartcard \
  --disable-libusb \
  --disable-live-block-migration \
  --disable-usb-redir \
  --disable-lzo \
  --disable-snappy \
  --disable-bzip2 \
  --disable-lzfse \
  --disable-seccomp \
  --disable-coroutine-pool \
  --disable-glusterfs \
  --disable-tpm \
  --disable-libssh2 \
  --disable-numa \
  --disable-libxml2 \
  --disable-tcmalloc \
  --disable-jemalloc \
  --disable-avx2 \
  --disable-replication \
  --disable-vhost-vsock \
  --disable-opengl \
  --disable-virglrenderer \
  --disable-xfsctl \
  --disable-qom-cast-debug \
  --disable-tools \
  --disable-vxhs \
  --disable-bochs \
  --disable-cloop \
  --disable-dmg \
  --disable-qcow1 \
  --disable-vdi \
  --disable-vvfat \
  --disable-qed \
  --disable-parallels \
  --disable-sheepdog \
  --disable-crypto-afalg \
  --disable-vhost-user \
  --disable-capstone \
  --disable-debug-mutex \
  --disable-libpmem \
  --enable-system \
  --enable-kvm \
  --enable-fdt \
  --enable-vhost-crypto \
  --enable-vhost-net \
  --enable-vhost-scsi \
  --enable-vhost-user \
  --enable-vhost-vsock \
  --enable-avx2 \
  --audio-drv-list="" \
  --extra-cflags=" -O3 -fno-semantic-interposition -falign-functions=32 -D_FORTIFY_SOURCE=2 -fPIE" \
  --extra-ldflags=" -pie -z noexecstack -z relro -z now"
popd

make -j $(nproc) -C "${BUILD_DIR}"
sudo make -j $(nproc) -C "${BUILD_DIR}" install

git clean -xdf
git submodule foreach git clean -xdf
git submodule foreach git submodule foreach git clean -xdf

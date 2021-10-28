#!/bin/sh
# Runs at startup, switches rootfs to the SSD on sda1 (SATA3 slot)
# If your SSD is NVME, Change "/dev/sda1" to "/dev/nvme0n1p1"
# Check your device name
# NVME SSD : /dev/nvme0n1p1
# SATA3 SSD : /dev/sda1
NVME_DRIVE="/dev/sda1"
CHROOT_PATH="/nvmeroot"

INITBIN=/lib/systemd/systemd
EXT4_OPT="-o defaults -o errors=remount-ro -o discard"

modprobe ext4

mkdir -p ${CHROOT_PATH}
mount -t ext4 ${EXT4_OPT} ${NVME_DRIVE} ${CHROOT_PATH}

cd ${CHROOT_PATH}
/bin/systemctl --no-block switch-root ${CHROOT_PATH}

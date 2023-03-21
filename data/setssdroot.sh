#!/bin/sh
# Runs at startup, switches rootfs to the SSD or USB

CHROOT_PATH="/newroot"
INITBIN=/lib/systemd/systemd
EXT4_OPT="-o defaults -o errors=remount-ro -o discard"

DEVICE_TYPE=$(grep -Po '(?<=DEVICE_TYPE=).*' /etc/setssdroot.conf)
DRIVE=""

if [ "$DEVICE_TYPE" == "nvme" ]; then
  DRIVE="/dev/nvme0n1p1"
elif [ "$DEVICE_TYPE" == "usb" ]; then
  DRIVE="/dev/sda1"
else
  echo "Invalid device type in /etc/setssdroot.conf. Supported types: nvme, usb"
  exit 1
fi

modprobe ext4

mkdir -p ${CHROOT_PATH}
mount -t ext4 ${EXT4_OPT} ${DRIVE} ${CHROOT_PATH}

cd ${CHROOT_PATH}
/bin/systemctl --no-block switch-root ${CHROOT_PATH}

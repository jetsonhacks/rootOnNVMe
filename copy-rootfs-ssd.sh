#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <nvme|usb>"
  exit 1
fi

device_type=$1
device_path=""

if [ "$device_type" == "nvme" ]; then
  device_path="/dev/nvme0n1p1"
elif [ "$device_type" == "usb" ]; then
  device_path="/dev/sda1"
else
  echo "Invalid device type. Supported types: nvme, usb"
  exit 1
fi

# Mount the device as /mnt
sudo mount $device_path /mnt
# Copy over the rootfs from the SD card to the device
sudo rsync -axHAWX --numeric-ids --info=progress2 --exclude={"/dev/","/proc/","/sys/","/tmp/","/run/","/mnt/","/media/*","/lost+found"} / /mnt
# We want to keep the device mounted for further operations
# So we do not unmount the device

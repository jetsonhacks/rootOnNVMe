#!/bin/bash
# Check your device name
# NVME SSD : /dev/nvme0n1p1
# SATA3 SSD : /dev/sda1

# Mount the SSD as /mnt
# sudo mount /dev/"your device name" /mnt
sudo mount /dev/sda1 /mnt
# Copy over the rootfs from the SD card to the SSD
sudo rsync -axHAWX --numeric-ids --info=progress2 --exclude={"/dev/","/proc/","/sys/","/tmp/","/run/","/mnt/","/media/*","/lost+found"} / /mnt
# We want to keep the SSD mounted for further operations
# So we do not unmount the SSD

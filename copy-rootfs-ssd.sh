#!/bin/bash
# Mount the SSD as /mnt
sudo mount /dev/nvme0n1p1 /mnt
# Copy over the rootfs from the SD card to the SSD
sudo rsync -aAXv --numeric-ids --info=progress2 --exclude={"/dev/","/proc/","/sys/","/tmp/","/run/","/mnt/","/media/*","/lost+found"} / /mnt
# Keep the SSD mounted for further operations

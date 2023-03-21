#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <nvme|usb>"
  exit 1
fi

device_type=$1

if [ "$device_type" != "nvme" ] && [ "$device_type" != "usb" ]; then
  echo "Invalid device type. Supported types: nvme, usb"
  exit 1
fi

# Setup the service to set the rootfs to point to the SSD
sudo cp data/setssdroot.service /etc/systemd/system
sudo cp data/setssdroot.sh /sbin
sudo bash -c "echo 'DEVICE_TYPE=$device_type' > /etc/setssdroot.conf"

sudo chmod 777 /sbin/setssdroot.sh
systemctl daemon-reload
sudo systemctl enable setssdroot.service

# Copy these over to the SSD
sudo cp /etc/systemd/system/setssdroot.service /mnt/etc/systemd/system/setssdroot.service
sudo cp /sbin/setssdroot.sh /mnt/sbin/setssdroot.sh

# Create setssdroot.conf which tells the service script to set the rootfs to the SSD
# If you want to boot from SD again, remove the file /etc/setssdroot.conf from the SD card.
# touch creates an empty file
echo 'Service to set the rootfs to the SSD installed.'
echo 'Make sure that you have copied the rootfs to SSD.'
echo 'Reboot for changes to take effect.'


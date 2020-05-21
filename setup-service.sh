#!/bin/sh
sudo cp setssdroot.service /etc/systemd/system
sudo cp setssdroot.sh /sbin
sudo chmod 777 /sbin/setssdroot.sh
systemctl daemon-reload
sudo systemctl enable setssdroot.service

# Copy these over to the SSD
sudo cp /etc/systemd/system/setssdroot.service /mnt/etc/systemd/system/setssdroot.service
sudo cp /sbin/setssdroot.sh /mnt/sbin/setssdroot.sh

# The create setssdroot.conf which tells the service script to set the rootfs to the SSD
# If you want to boot from SD again, remove this file /etc/setssdroot.conf
# touch will create an empty file
sudo touch /etc/setssdroot.conf


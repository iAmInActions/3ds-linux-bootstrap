#!/bin/sh

# Initialisation stuff goes here
fbv --delay 20 /splash.png # Display splash for 2 seconds
mount /dev/mmcblk0p1 /sdcard/
if [ -e /sdcard/linux/swap.img ]; then
  echo "Found a swap space, adding extra memory."
  swapon /sdcard/linux/swap.img
fi

## BOOTLOADER MODE ##
echo "Scanning for bootable media..."

# Check if a custom boot config exists (overwrites boot device detection) and if yes, attempt booting.
if [ -e /sdcard/linux/boot.cfg ]; then
  echo "Found a custom configuration, attempting to boot..."
  /bootfromcfg.sh
else
  echo "No custom configuration present."
fi

# Check if RootFS partition (second SD card partition) exists and if yes, attempt booting.
# Define boot arguments below:
bootargs=""
if [ -e /dev/mmcblk0p2 ]; then
  echo "RootFS found on mmcblk0p2, attempting to boot..."
  mount /dev/mmcblk0p2 /newroot
  # Find init location.
  if [ -e /newroot/init ]; then
    switch_root /newroot /init $bootargs
  elif [ -e /newroot/bin/init ]; then
    switch_root /newroot /bin/init $bootargs
  elif [ -e /newroot/sbin/init ]; then
    switch_root /newroot /sbin/init $bootargs
  elif [ -e /newroot/usr/bin/init ]; then
    switch_root /newroot /usr/bin/init $bootargs
  elif [ -e /newroot/usr/sbin/init ]; then
    switch_root /newroot /usr/sbin/init $bootargs
  else
    echo "No init found on partition."
  fi
else
  echo "No rootfs partition present."
fi

# Check if RootFS image exists on the SD card and if yes, attempt booting.
if [ -e /sdcard/linux/rootfs.img ]; then
  echo "RootFS imge found, attempting to boot..."
  mount /sdcard/linux/rootfs.img /newroot
  # Find init location.
  if [ -e /newroot/init ]; then
    switch_root /newroot /init $bootargs
  elif [ -e /newroot/bin/init ]; then
    switch_root /newroot /bin/init $bootargs
  elif [ -e /newroot/sbin/init ]; then
    switch_root /newroot /sbin/init $bootargs
  elif [ -e /newroot/usr/bin/init ]; then
    switch_root /newroot /usr/bin/init $bootargs
  elif [ -e /newroot/usr/sbin/init ]; then
    switch_root /newroot /usr/sbin/init $bootargs
  else
    echo "No init found on image."
  fi
else
  echo "No rootfs image present."
fi

# If no bootable media is found, drop into a shell.
clear
echo "Welcome to 3DS Linux!"
echo ""
echo "No RootFS partition or disk image was found."
echo "Running in minimal RAM disk mode."
/bin/sh
halt

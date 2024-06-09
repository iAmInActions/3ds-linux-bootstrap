#!/bin/sh

# Initialisation stuff goes here
fbv --delay 20 /splash.png # Display splash for 3 seconds
mount /dev/mmcblk0p1 /sdcard/

clear
echo "Welcome to 3DS Linux!"
echo ""
/bin/sh

#!/bin/sh

# Read the boot configuration file
CFG_FILE="/sdcard/linux/boot.cfg"

# Ensure the file exists
if [ ! -f "$CFG_FILE" ]; then
  echo "E: Configuration file not readable."
  exit 1
fi

# Read lines from the configuration file
LINE1=$(sed -n '1p' "$CFG_FILE")
LINE2=$(sed -n '2p' "$CFG_FILE")
LINE3=$(sed -n '3p' "$CFG_FILE")

# Check if lines are read correctly
if [ -z "$LINE1" ] || [ -z "$LINE2" ] ; then
  echo "E: Configuration file is incomplete."
  exit 1
fi

# Execute the commands with the configuration parameters
mount "$LINE1" /newroot
switch_root /newroot "$LINE2" $LINE3

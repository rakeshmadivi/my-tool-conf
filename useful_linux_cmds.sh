#!/bin/bash

# System RunLevel / Target

# Get the Current Target
runlevel    # Will return the numerical value of runlevel
systemctl get-default   # Returns Current run level

# View all loaded targets
systemctl list-units --type target

# List all active,inactive targets
systemctl list-units --type target --all

# Changing the target
sudo systemctl set-default runlevel3.target

# Change the target only in the current session
sudo systemctl isolate runlevel3.target

# Check run level using 'who' command
who -r


# NVME DEVICE RELATED COMMANDS
: '
nvme --version NVMe CLI version
 nvme help List of all commands
 sudo nvme list Lists out nvme devices, capacity, namespace, format and FW rev
 sudo nvme format /dev/nvme0 –s 1 Format with secure erase option
 sudo nvme id-ctrl /dev/nvme0 Identify controller details
 sudo nvme intel id-ctrl /dev/nvme0n1 Identify controller details - few additional details added (e.g. drive
health, boot loader)
 sudo nvme intel market-name /dev/nvme0n1 Marketing series name
 sudo nvme id-ns /dev/nvme0n1 Identify namespace details
 sudo nvme get-log /dev/nvme0 --log-id=2 --log-len=512 Read log page
 sudo nvme smart-log /dev/nvme0 Smart log
 sudo nvme error-log /dev/nvme0 | less Shows error logs
 sudo nvme fw-download /dev/nvme0n1 -f <fw binary> Expected result: Firmware download success
 sudo nvme fw-commit /dev/nvme0n1 -s 1 -a 1 Expected result: Success activating firmware action:1 slot:1
 sudo nvme reset /dev/nvme0 Resets the nvme controller
 '
# commands related to devices
dd if=/dev/zero of=${HOME}/dd_generated.img
blockdev --getbsz /dev/zero # To get block size of device

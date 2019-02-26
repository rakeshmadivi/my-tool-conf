#!/bin/bash

file=loopbackfile.img

# Create file of desired size
dd if=/dev/zero of=${file} bs=100M count=10

# Check the created file size
du -hs $file

# Create loop device with the created file
losetup -fP $file

# view all the loop devices
losetup -a

# Format the loop device with ext4 filesystem
mkfs.ext4 /root/${file}

# Create a directory under root
mkdir /loopfs

# Get where the loop device located
location=losetup -a | grep $file|awk '{print $1}'

# mount the loop device on to the created directory
sudo mount -o loop $location /loopfs

# Verify the size of the mounted loop file
df -hP /loopfs
mount | grep loopfs

# Unmount and delete the loop partition
#unmount /loopfs
#rm -rf /loopfs

#losetup -d $location

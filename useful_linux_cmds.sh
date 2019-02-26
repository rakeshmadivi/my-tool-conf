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

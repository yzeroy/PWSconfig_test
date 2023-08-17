#!/bin/bash

devices=$(find /dev/v4l/by-id/ -name "*index0")

for device in $devices; do

    device_name=$(basename "$device")
   
    ln -sf "$device" "/home/pi/cam0"
done

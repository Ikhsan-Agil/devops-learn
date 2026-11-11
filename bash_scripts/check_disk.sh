#!/bin/bash
disk="$(df -h | grep -i "/dev/root" | awk '{print $5}')"
disk_cleaned="${disk%\%}"

echo "Root Disk Usage: ${disk}"

if [ "$disk_cleaned" -ge 80 ]; then
	echo "WARNING: High disk usage!"
else
	echo "Disk space is healthy"
fi

#!/bin/bash
disk="$(df -h | awk '$NF=="/" {print $5}')"
disk_cleaned="${disk%\%}"

if [[ "$disk_cleaned" =~ ^[0-9]+$ ]]; then
	echo "Root Disk Usage: ${disk}"
	if [ "$disk_cleaned" -ge 80 ]; then
		echo "WARNING: High disk usage!"
	else
		echo "Disk space is healthy"
	fi
else
	echo "ERROR: Failed to retrieve the root disk"
	exit 1
fi

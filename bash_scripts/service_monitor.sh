#!/bin/bash

TARGET_SERVICE="nginx"
LOG_FILE_PATH="./logs/nginx_service_monitor_sample.log"

i=0
while true; do
	TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

	if systemctl is-active --quiet $TARGET_SERVICE; then
		echo "[${TIMESTAMP}] The $TARGET_SERVICE Service is Healthy" >> $LOG_FILE_PATH
	else
		echo "[${TIMESTAMP}] WARNING: $TARGET_SERVICE is down! Attempting restart..." >> $LOG_FILE_PATH
		sudo systemctl restart "$TARGET_SERVICE"

		(( i++ ))

		if [ $i -eq 3 ]; then
			echo "[${TIMESTAMP}] FATAL_ERROR: $TARGET_SERVICE has restarted by 3 times and still down! " >> $LOG_FILE_PATH
			exit
		fi
	fi

	sleep 30
done


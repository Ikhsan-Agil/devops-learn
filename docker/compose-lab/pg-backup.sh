FILE_DATE=$(date +%Y-%m-%d_%H-%M-%S)
DATE=$(date +%Y-%m-%d_%H:%M:%S)
PROJECT_DIR=$(pwd)
BACKUP_DIR="$PROJECT_DIR/db-backups"
BACKUP_SCRIPT_LOG="$PROJECT_DIR/backup-logs.log"

if [ ! -d "$BACKUP_DIR" ]; then
	mkdir -p "$BACKUP_DIR"
fi

# Run Backup Script
echo "[ $DATE ] Starting PostgreSQL Database backup..." >> "$BACKUP_SCRIPT_LOG"
/usr/bin/docker run --rm -v compose-lab_pgdata:/volume -v "$BACKUP_DIR":/backup alpine tar czf /backup/pgdata-backup-"$FILE_DATE".tar.gz -C /volume .

# Analyze whether the backup task is finished successfully
if [ $? -eq 0 ]; then
	echo "PostgreSQL Database Backup is finished at $DATE" >> "$BACKUP_SCRIPT_LOG"

	# Find the file that exists more than 7 days
	find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -exec rm {} \;

	# Analyze whether the prune process is finished successfully
	if [ $? -eq 0 ]; then
		echo "[ $DATE ] Database backup files that more than 7 days successfully pruned" >> "$BACKUP_SCRIPT_LOG"
	else
		echo "ERROR: Database backup files that more than 7 days failed to prune" | tee -a "$BACKUP_SCRIPT_LOG" >&2
		exit 1
	fi
else
	echo "ERROR: PostgreSQL Database Backup is failed at $DATE" | tee -a "$BACKUP_SCRIPT_LOG" >&2
	exit 1
fi

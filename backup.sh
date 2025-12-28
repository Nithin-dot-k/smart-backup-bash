#!/bin/bash

set -euo pipefail

# Absolute path of this script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


#load config file
CONFIG_FILE="$SCRIPT_DIR/config.conf"

#check if the config file exits
if [ ! -f "$CONFIG_FILE" ]
then
   echo "config file not found.."
   exit 1
fi

SOURCE_DIR=""
TARGET_DIR=""
DRY_RUN=false

source "$CONFIG_FILE"

#Validate config file
if [ -z "$SOURCE_DIR" ] || [ -z "$TARGET_DIR" ]
then
   echo "SOURCE_DIR or TARGET_DIR is missing.."
   exit 2
fi

#check if the SOURCE_DIR exits
if [ ! -d "$SOURCE_DIR" ]
then
   echo "source directory does not exit.."
   exit 3
fi


#gets current date of backup
current_date=$(date +%Y-%m-%d)


# Prepare directories
mkdir -p "$TARGET_DIR/current" "$TARGET_DIR/$current_date"
mkdir -p "$SCRIPT_DIR/logs"

LOG_FILE="$SCRIPT_DIR/logs/backup_$current_date.log"

RSYNC_BIN=$(command -v rsync 2>/dev/null)

#Check rsync
if [ -z "$RSYNC_BIN" ]
then
   echo "rsync is not installed.."
   echo "use this command to install 'sudo apt update && sudo apt install rsync'"
   exit 4
fi

# rsync options (array = safe)
RSYNC_OPTS=(-avb --delete --backup-dir="$TARGET_DIR/$current_date")

if [ "$DRY_RUN" = "true" ]
then
   RSYNC_OPTS+=(-n)
fi

# Run backup
"$RSYNC_BIN" "${RSYNC_OPTS[@]}" "$SOURCE_DIR/" "$TARGET_DIR/current/" >> "$LOG_FILE" 2>&1

echo "Backup completed in $current_date" >> "$LOG_FILE"

exit 0

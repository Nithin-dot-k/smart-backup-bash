#!/bin/bash

# To check if the user enter the two arguments for the script
if [ $# -ne 2 ]
then
   echo "Usage: backup.sh <source_directory> <target_directory>"
   echo "Please try again..."
   exit 1
fi

# To check the rsync is installed
which rsync &> /dev/null 

# if rsync not installed this statement excutes 
if [ $? -ne 0 ]
then
   echo "The script requires rsync to be installed..."
   echo "use : sudo apt update && sudo apt install rsync"
   echo "Please try again..."
   exit 2
fi

# capture the current date and store in the year-month-day format
current_date=$(date +%Y-%m-%d)

#in backup store the files which altered in source dir and backuped in $current_date folder
rsync_option="-avb --backup-dir $2/$current_date --delete"

$(which rsync) $rsync_option $1 $2/current >> backup_$current_date.log

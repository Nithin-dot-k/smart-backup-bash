# Smart Backup Bash Script

A reliable Bash script for incremental backups using `rsync`.  
Maintains the latest backup in a `current/` directory while storing older versions of modified or deleted files in date-based folders.

---

## Features

- Incremental backups with `rsync`
- Latest backup stored separately
- Versioned backups using date-based directories
- Automatic logging
- Safe execution with validations
- Automation-friendly (cron-ready)

---

## Directory Structure

smart-backup-bash/
├── backup.sh
├── config.conf
├── backups/
├── logs/
├── README.md
└── .gitignore

---

## Configuration

Edit `config.conf`:

```bash
SOURCE_DIR="/path/to/source"
TARGET_DIR="/path/to/backups"

usage:

bash backup.sh

---

##Requirements:

* rsync installed

* Valid source directory

* Write access to target directory

---

##Backup Strategy:

backups/
├── current/
└── YYYY-MM-DD/

* current/ → latest backup

* Date folders → old versions of changed/deleted files

---

##Logging

Logs are stored in:

logs/backup_YYYY-MM-DD.log


Includes:

* File operations

* rsync output

* Errors

---

##Exit Codes

| Code | Meaning                  |
| ---- | ------------------------ |
| 0    | Success                  |
| 1    | Config file missing      |
| 2    | Invalid configuration    |
| 3    | Source directory missing |
| 4    | rsync not installed      |


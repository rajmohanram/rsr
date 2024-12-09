# Created Date: Monday, December 9th 2024, 10:00:00 pm
# Author: Rajasekar Ramamoorthy
# Usage: ./script01.sh backup
# Description: This script will back up a directory to a specified location.

#!/bin/bash

# Variables
# Define the source directory, backup directory, and log file
# Change these values to match your setup
# The source directory is the directory you want to back up
# The backup directory is where the backup will be saved
# The log file is where the script will log its actions
SOURCE_DIR="$HOME/Documents/build-squid"
BACKUP_DIR="$HOME/Backup"
LOG_FILE="$BACKUP_DIR/backup.log"

# Function to create a backup
# This function will create a tar.gz archive of the source directory
# and save it to the backup directory with a timestamped name
# If the backup directory does not exist, it will be created
# The script will also log the backup creation to the log file

create_backup() {
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
    fi

    # Create a timestamped backup name
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

    tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$SOURCE_DIR" .
    echo "Backup created at $BACKUP_DIR/$BACKUP_NAME" >> "$LOG_FILE"
}

# Function to display usage
# This function will be called when the user provides
# incorrect arguments or requests help
usage() {
    echo "Usage: $0 [backup|help]"
    exit 1
}

# Main script logic
# Check if any arguments are provided
# and call the appropriate function
# If no arguments are provided, display usage information
# $# is the number of arguments passed to the script
if [ $# -eq 0 ]; then
    usage
fi

# Check the first argument and call the appropriate function
# If the argument is "backup", call the create_backup function
# If the argument is "help", call the usage function
# Otherwise, call the usage function
case $1 in
    backup)
        create_backup
        ;;
    help)
        usage
        ;;
    *)
        usage
        ;;
esac


# Here's a simple bash script that demonstrates basic concepts 
# like variables, conditionals, loops, and functions.

# This script will back up a directory to a specified location. 
# It also includes a usage function to display help information.

# Save this script as backup_script.sh, make it executable with 
# chmod +x backup_script.sh, and run it with ./backup_script.sh backup 
# to create a backup of your Documents directory.
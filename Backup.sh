#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  exit 1
fi

# Check if source directory exists
source_directory=$1
if [ ! -d "$source_directory" ]; then
  echo "Error: Source directory does not exist."
  exit 1
fi

# Set up destination and backup directories
destination_directory=$2
timestamp=$(date +'%Y_%m_%d_%H-%M-%S')
backup_directory="$destination_directory/backup_$timestamp.tar.gz"

# Check if destination directory already exists
if [ -d "$destination_directory" ]; then
  echo "Error: Destination directory already exists."
  exit 1
else
  mkdir -p "$destination_directory"
  echo "Successfully created backup directory: $destination_directory"
fi

# Create backup
tar -czf "$backup_directory" -C "$(dirname "$source_directory")" "$(basename "$source_directory")"

# Check if backup creation was successful
if [ $? -eq 0 ]; then
  echo "Backup created successfully: $backup_directory"
else
  echo "Error: Backup creation failed."
  exit 1
fi

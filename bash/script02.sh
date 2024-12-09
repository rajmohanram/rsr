#!/bin/bash

# Variables
# Define variables for the directory, countdown, and target file
DIRECTORY="$HOME/Documents"
COUNTDOWN=5
TARGET_FILE="$HOME/Documents/target.txt"

# For loop: Iterate over files in a directory
# List all files in the specified directory
# $DIRECTORY is the directory path
# * is a wildcard that matches all files in the directory
# The loop iterates over each file in the directory
# $FILE is the current file in the loop

echo "Listing files in $DIRECTORY:"
for FILE in "$DIRECTORY"/*; do
    echo "File: $FILE"
done

# While loop: Countdown from a number
# Display a countdown from a specified number
# $COUNTDOWN is the starting number
# The loop decrements the countdown by 1 each time
# The loop continues until the countdown reaches 0

echo "Countdown from $COUNTDOWN:"
while [ $COUNTDOWN -gt 0 ]; do
    echo "$COUNTDOWN"
    COUNTDOWN=$((COUNTDOWN - 1))
    sleep 1
done

# Until loop: Check for the existence of a file
# Check if a target file exists
# $TARGET_FILE is the file to check for
# The loop continues until the file is created

echo "Waiting for $TARGET_FILE to be created..."
until [ -f "$TARGET_FILE" ]; do
    echo "File not found. Checking again in 2 seconds..."
    sleep 2
done
echo "File $TARGET_FILE found!"

# a sample bash script that demonstrates various loops (for, while, until) with practical examples. This script will iterate over files in a directory, count down from a number, and check for a condition until it's met.

# Save this script as loop_examples.sh, make it executable with chmod +x loop_examples.sh, and run it with ./loop_examples.sh to see the loops in action.
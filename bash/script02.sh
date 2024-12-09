#!/bin/bash

# Variables
DIRECTORY="$HOME/Documents"
COUNTDOWN=5
TARGET_FILE="$HOME/Documents/target.txt"

# For loop: Iterate over files in a directory
echo "Listing files in $DIRECTORY:"
for FILE in "$DIRECTORY"/*; do
    echo "File: $FILE"
done

# While loop: Countdown from a number
echo "Countdown from $COUNTDOWN:"
while [ $COUNTDOWN -gt 0 ]; do
    echo "$COUNTDOWN"
    COUNTDOWN=$((COUNTDOWN - 1))
    sleep 1
done

# Until loop: Check for the existence of a file
echo "Waiting for $TARGET_FILE to be created..."
until [ -f "$TARGET_FILE" ]; do
    echo "File not found. Checking again in 2 seconds..."
    sleep 2
done
echo "File $TARGET_FILE found!"

# a sample bash script that demonstrates various loops (for, while, until) with practical examples. This script will iterate over files in a directory, count down from a number, and check for a condition until it's met.

# Save this script as loop_examples.sh, make it executable with chmod +x loop_examples.sh, and run it with ./loop_examples.sh to see the loops in action.
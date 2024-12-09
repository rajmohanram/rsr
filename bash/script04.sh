#!/bin/bash

# Define an array to hold filenames
# The -a flag is used to explicitly declare an indexed array
# The array is empty initially

declare -a filenames

# Directory to scan for files
# Change this to the directory you want to list files from

directory="$HOME/Documents"

# Populate the array with filenames from the directory
# Loop through each file in the directory and add its name to the array
# basename extracts the filename from the full path

for file in "$directory"/*; do
  filenames+=("$(basename "$file")")
    # filenames+=("$file")
done

# Display the filenames stored in the array
# Loop through the array and print each filename
# ${filenames[@]} expands to all elements of the array

echo "Files in $directory:"
for filename in "${filenames[@]}"; do
  echo "$filename"
done
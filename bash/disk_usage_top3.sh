#!/bin/bash

# Read the disk usage details from the file
disk_usage=$(cat disk-input.txt)

# Extract the header and the disk usage details (excluding the header)
header=$(echo "$disk_usage" | head -n 1)
usage_details=$(echo "$disk_usage" | tail -n +2)

# Sort the disk usage details by the "Used" column in descending order and get the top 3
# The disk usage details are sorted by the "Used" column in descending order
# The top 3 disks with the highest used space are extracted
# sort -rk 4 sorts by the 4th column (Used) in reverse order (descending)
# head -n 3 extracts the top 3 disks

top_3_disks=$(echo "$usage_details" | sort -rk 4 | head -n 3)

# Extract and print only the "Filesystem", "Type", and "Used" columns
# awk is used to print the 1st, 2nd, and 4th columns

echo "$header" | awk '{print $1, $2, $4}'
echo "$top_3_disks" | awk '{print $1, $2, $4}'

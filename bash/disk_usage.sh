#!/bin/bash

# Get disk usage details
disk_usage=$(df -hT | grep ext4)

# Sort and display the top 3 disk usages
echo "Top 3 disk usages:"
echo "$disk_usage" | sort -rk 6 | head -n 3

# Sort and display the bottom 4 disk usages
echo "Bottom 4 disk usages:"
echo "$disk_usage" | sort -k 6 | head -n 4
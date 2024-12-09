#!/bin/bash

# Display the name of the script
echo "Name of the script: $0"

# Check if any arguments are supplied
# If no arguments are provided, display an error message
# Otherwise, display the number of arguments and each argument
# $# is the number of arguments passed to the script
if [ $# -eq 0 ]; then
  echo "No arguments supplied."
else
  echo "Number of arguments supplied: $#"
fi

# Display each argument
# Loop through each argument and print it
# $@ is an array of all the arguments passed to the script

for arg in "$@"; do
  echo "Argument: $arg"
done
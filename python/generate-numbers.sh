#!/bin/bash

# Function to generate a random phone number
generate_phone_number() {
  echo "$((RANDOM % 900 + 100))-$((RANDOM % 900 + 100))-$((RANDOM % 9000 + 1000))"
}

# File to store the phone numbers
file="phone-numbers.txt"

# Clear the file if it exists
> "$file"

# Generate and append 30 random phone numbers to the file
for i in {1..30}; do
  generate_phone_number >> "$file"
done

echo "30 random phone numbers have been generated and saved to $file."
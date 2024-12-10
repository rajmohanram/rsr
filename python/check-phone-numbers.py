import re
from collections import Counter

# Define the regex pattern for the phone number format 111-222-3333
# ^\d{3}-\d{3}-\d{4}$
# ^ - Start of the line
# \d{3} - Three digits
# - - Hyphen
# \d{3} - Three digits
# - - Hyphen
# \d{4} - Four digits
# $ - End of the line

pattern = re.compile(r'^\d{3}-\d{3}-\d{4}$')

# Read the phone numbers from the file

with open('phone-numbers.txt', 'r') as file:
    phone_numbers = file.readlines()

# List to store invalid phone numbers

invalid_phone_numbers = []

# Find phone numbers that do not match the pattern
# and store them in the invalid_phone_numbers list

for number in phone_numbers:
    if not pattern.match(number.strip()):
        invalid_phone_numbers.append(number.strip())

# Print the invalid phone numbers

print("Invalid phone numbers:")
for number in invalid_phone_numbers:
    print(number)

# Save the invalid phone numbers to output1.txt

with open('output1.txt', 'w') as output_file:
    for number in invalid_phone_numbers:
        output_file.write(number + '\n')


# List to store valid phone numbers
valid_phone_numbers = []

# Extract valid phone numbers
# and store them in the valid_phone_numbers list

for number in phone_numbers:
    if pattern.match(number.strip()):
        valid_phone_numbers.append(number.strip())


# List to store area codes

area_codes = []

# Extract area codes from valid phone numbers
for number in valid_phone_numbers:
    area_codes.append(number.split('-')[0])

# Find the top 3 most common area codes
# and store them in the top_3_area_codes list

top_3_area_codes = Counter(area_codes).most_common(3)

# Print the top 3 area codes
# and their counts
print("\nTop 3 area codes:")
for area_code, count in top_3_area_codes:
    print(f"{area_code}: {count}")

# Save the top 3 area codes to output2.txt

with open('output2.txt', 'w') as output_file:
    for area_code, count in top_3_area_codes:
        output_file.write(f"{area_code}: {count}\n")

# Run the script and check the output1.txt file for invalid phone numbers
# python check-phone-numbers.py

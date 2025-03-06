package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"sort"
	"strings"
)

// PhoneNumber represents a phone number string
type PhoneNumber string

// AreaCode represents an area code string
type AreaCode string

// AreaCodeCount represents an area code and its count
type AreaCodeCount struct {
	Code  AreaCode
	Count int
}

// ByCount implements sort.Interface for []AreaCodeCount based on the Count field.
type ByCount []AreaCodeCount

func (a ByCount) Len() int           { return len(a) }
func (a ByCount) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByCount) Less(i, j int) bool { return a[i].Count > a[j].Count }

func main() {
	// Define the regex pattern for the phone number format 111-222-3333
	pattern := regexp.MustCompile(`^\d{3}-\d{3}-\d{4}$`)

	// Read phone numbers from the file
	phoneNumbers, err := readPhoneNumbersFromFile("phone-numbers.txt")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading phone numbers: %v\n", err)
		os.Exit(1)
	}

	// Find invalid phone numbers
	invalidPhoneNumbers := findInvalidPhoneNumbers(phoneNumbers, pattern)

	// Print invalid phone numbers
	fmt.Println("Invalid phone numbers:")
	for _, number := range invalidPhoneNumbers {
		fmt.Println(number)
	}

	// Save invalid phone numbers to output1.txt
	if err := savePhoneNumbersToFile("output1.txt", invalidPhoneNumbers); err != nil {
		fmt.Fprintf(os.Stderr, "Error saving invalid phone numbers: %v\n", err)
		os.Exit(1)
	}

	// Find valid phone numbers
	validPhoneNumbers := findValidPhoneNumbers(phoneNumbers, pattern)

	// Extract area codes
	areaCodes := extractAreaCodes(validPhoneNumbers)

	// Find the top 3 most common area codes
	top3AreaCodes := findTop3AreaCodes(areaCodes)

	// Print the top 3 area codes and their counts
	fmt.Println("\nTop 3 area codes:")
	for _, acc := range top3AreaCodes {
		fmt.Printf("%s: %d\n", acc.Code, acc.Count)
	}

	// Save the top 3 area codes to output2.txt
	if err := saveAreaCodesToFile("output2.txt", top3AreaCodes); err != nil {
		fmt.Fprintf(os.Stderr, "Error saving top area codes: %v\n", err)
		os.Exit(1)
	}
}

// readPhoneNumbersFromFile reads phone numbers from a file and returns them as a slice.
func readPhoneNumbersFromFile(filename string) ([]PhoneNumber, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var phoneNumbers []PhoneNumber
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		phoneNumbers = append(phoneNumbers, PhoneNumber(strings.TrimSpace(scanner.Text())))
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return phoneNumbers, nil
}

// findInvalidPhoneNumbers finds phone numbers that do not match the given pattern.
func findInvalidPhoneNumbers(phoneNumbers []PhoneNumber, pattern *regexp.Regexp) []PhoneNumber {
	var invalidPhoneNumbers []PhoneNumber
	for _, number := range phoneNumbers {
		if !pattern.MatchString(string(number)) {
			invalidPhoneNumbers = append(invalidPhoneNumbers, number)
		}
	}
	return invalidPhoneNumbers
}

// findValidPhoneNumbers finds phone numbers that match the given pattern.
func findValidPhoneNumbers(phoneNumbers []PhoneNumber, pattern *regexp.Regexp) []PhoneNumber {
	var validPhoneNumbers []PhoneNumber
	for _, number := range phoneNumbers {
		if pattern.MatchString(string(number)) {
			validPhoneNumbers = append(validPhoneNumbers, number)
		}
	}
	return validPhoneNumbers
}

// extractAreaCodes extracts area codes from a slice of valid phone numbers.
func extractAreaCodes(validPhoneNumbers []PhoneNumber) []AreaCode {
	var areaCodes []AreaCode
	for _, number := range validPhoneNumbers {
		parts := strings.Split(string(number), "-")
		if len(parts) > 0 {
			areaCodes = append(areaCodes, AreaCode(parts[0]))
		}
	}
	return areaCodes
}

// findTop3AreaCodes finds the top 3 most common area codes.
func findTop3AreaCodes(areaCodes []AreaCode) []AreaCodeCount {
	areaCodeCounts := make(map[AreaCode]int)
	for _, code := range areaCodes {
		areaCodeCounts[code]++
	}

	var accs []AreaCodeCount
	for code, count := range areaCodeCounts {
		accs = append(accs, AreaCodeCount{Code: code, Count: count})
	}

	sort.Sort(ByCount(accs))

	if len(accs) > 3 {
		return accs[:3]
	}
	return accs
}

// savePhoneNumbersToFile saves phone numbers to a file.
func savePhoneNumbersToFile(filename string, phoneNumbers []PhoneNumber) error {
	file, err := os.Create(filename)
	if err != nil {
		return err
	}
	defer file.Close()

	writer := bufio.NewWriter(file)
	for _, number := range phoneNumbers {
		fmt.Fprintln(writer, number)
	}
	return writer.Flush()
}

// saveAreaCodesToFile saves area codes to a file.
func saveAreaCodesToFile(filename string, top3AreaCodes []AreaCodeCount) error {
	file, err := os.Create(filename)
	if err != nil {
		return err
	}
	defer file.Close()

	writer := bufio.NewWriter(file)
	for _, acc := range top3AreaCodes {
		fmt.Fprintf(writer, "%s: %d\n", acc.Code, acc.Count)
	}
	return writer.Flush()
}

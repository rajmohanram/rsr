package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"sort"
	"strings"
)

func main() {
	// Define the regex pattern for the phone number format 111-222-3333
	pattern := regexp.MustCompile(`^\d{3}-\d{3}-\d{4}$`)

	// Open the phone-numbers.txt file
	file, err := os.Open("phone-numbers.txt")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	// Lists to store invalid and valid phone numbers
	var invalidPhoneNumbers []string
	var validPhoneNumbers []string

	// Read the phone numbers from the file
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		number := scanner.Text()
		if !pattern.MatchString(number) {
			invalidPhoneNumbers = append(invalidPhoneNumbers, number)
		} else {
			validPhoneNumbers = append(validPhoneNumbers, number)
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading file:", err)
		return
	}

	// Print the invalid phone numbers
	fmt.Println("Invalid phone numbers:")
	for _, number := range invalidPhoneNumbers {
		fmt.Println(number)
	}

	// Save the invalid phone numbers to output1.txt
	output1, err := os.Create("output1.txt")
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer output1.Close()

	for _, number := range invalidPhoneNumbers {
		output1.WriteString(number + "\n")
	}

	// Map to store area codes and their counts
	areaCodeCounts := make(map[string]int)

	// Extract area codes from valid phone numbers
	for _, number := range validPhoneNumbers {
		areaCode := strings.Split(number, "-")[0]
		areaCodeCounts[areaCode]++
	}

	// Find the top 3 most common area codes
	type areaCodeCount struct {
		AreaCode string
		Count    int
	}
	var areaCodeList []areaCodeCount
	for areaCode, count := range areaCodeCounts {
		areaCodeList = append(areaCodeList, areaCodeCount{AreaCode: areaCode, Count: count})
	}

	sort.Slice(areaCodeList, func(i, j int) bool {
		return areaCodeList[i].Count > areaCodeList[j].Count
	})

	top3AreaCodes := areaCodeList
	if len(areaCodeList) > 3 {
		top3AreaCodes = areaCodeList[:3]
	}

	// Print the top 3 area codes and their counts
	fmt.Println("\nTop 3 area codes:")
	for _, ac := range top3AreaCodes {
		fmt.Printf("%s: %d\n", ac.AreaCode, ac.Count)
	}

	// Save the top 3 area codes to output2.txt
	output2, err := os.Create("output2.txt")
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer output2.Close()

	for _, ac := range top3AreaCodes {
		output2.WriteString(fmt.Sprintf("%s: %d\n", ac.AreaCode, ac.Count))
	}
}

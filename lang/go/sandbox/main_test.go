package main

import "testing"

func TestTest(t *testing.T) {
	result := Test(3, 4)
	if result != 7 {
		t.Errorf("Expected 7, but got %d", result)
	}

	result = Test(5, 5)
	if result != 10 {
		t.Errorf("Expected 10, but got %d", result)
	}

	// Add more test cases as needed
}

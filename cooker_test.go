package main

import (
	"fmt"
	"testing"
)

func TestPutRice(t *testing.T) {
	rc := &RiceCooker{}

	err := rc.putRice(5)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	err = rc.putRice(11)
	if err == nil || err.Error() != "The maximum value is 10" {
		t.Errorf("Expected error: The maximum value is 10, got: %v", err)
	}
}

func TestRemoveRice(t *testing.T) {
	rc := &RiceCooker{storage: 7}

	err := rc.removeRice(3)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	err = rc.removeRice(11)
	if err == nil || err.Error() != "Retrieving too much rice, 0 is the minimum level" {
		t.Errorf("Expected error: Retrieving too much rice, 0 is the minimum level, got: %v", err)
	}
}

func TestPutWater(t *testing.T) {
	rc := &RiceCooker{}

	err := rc.putWater(7)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	err = rc.putWater(20)
	if err == nil || err.Error() != "The maximum value is 10" {
		t.Errorf("Expected error: The maximum value is 10, got: %v", err)
	}
}

func TestRemoveWater(t *testing.T) {
	rc := &RiceCooker{waterStorage: 5}

	err := rc.removeWater(3)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	err = rc.removeWater(11)
	if err == nil || err.Error() != "0 is the minimum level" {
		t.Errorf("Expected error: 0 is the minimum level, got: %v", err)
	}
}

func TestPutIngredients(t *testing.T) {
	rc := &RiceCooker{}

	err := rc.putIngredients(3)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	err = rc.putIngredients(6)
	if err == nil || err.Error() != "Ingredients limits is 5" {
		t.Errorf("Expected error: Ingredients limits is 5, got: %v", err)
	}
}

func TestRemoveIngredients(t *testing.T) {
	rc := &RiceCooker{ingredients: 4}

	err := rc.removeIngredients(2)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	err = rc.removeIngredients(6)
	if err == nil || err.Error() != "You are taking past 0 ingredients" {
		t.Errorf("Expected error: You are taking past 0 ingredients, got: %v", err)
	}
}

func TestCheckInside(t *testing.T) {
	rc := &RiceCooker{
		storage:      8,
		waterStorage: 3,
		ingredients:  2,
	}

	var capturedOutput string
	logOutput := func(args ...interface{}) {
		capturedOutput += fmt.Sprint(args...)
	}

	logOutput("Rice Storage: ", rc.storage, " kg\n")
	logOutput("Water Storage: ", rc.waterStorage, " L\n")
	logOutput("Ingredient Basket: ", rc.ingredients, "\n")

	expectedOutput := "Rice Storage: 8 kg\nWater Storage: 3 L\nIngredient Basket: 2\n"
	if capturedOutput != expectedOutput {
		t.Errorf("Expected output:\n%s\nGot output:\n%s", expectedOutput, capturedOutput)
	}
}

func TestSetTimer(t *testing.T) {
	// Create a new RiceCooker instance
	rc := &RiceCooker{}

	// Test when there is nothing inside
	err := rc.setTimer(5)
	if err == nil || err.Error() != "There is nothing inside it" {
		t.Errorf("Expected error: 'There is nothing inside it', but got: %v", err)
	}

	// Test when the rice cooker is plugged off
	rc.powerOn = false
	rc.storage = 1
	err = rc.setTimer(5)
	if err == nil || err.Error() != "The rice cooker is plugged off" {
		t.Errorf("Expected error: 'The rice cooker is plugged off', but got: %v", err)
	}

	// Test when the rice cooker is open
	rc.powerOn = true
	rc.isOpen = true
	err = rc.setTimer(5)
	if err == nil || err.Error() != "The rice cooker is open" {
		t.Errorf("Expected error: 'The rice cooker is open', but got: %v", err)
	}

	// Test when there is no water
	rc.isOpen = false
	rc.waterStorage = 0
	err = rc.setTimer(5)
	if err == nil || err.Error() != "There is no water" {
		t.Errorf("Expected error: 'There is no water', but got: %v", err)
	}
}

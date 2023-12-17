package main

import (
	"errors"
	"fmt"
)

type RiceCooker struct {
	storage         int
	waterStorage    int
	ingredients     int
	timer           int
	isOpen          bool
	powerOn         bool
	isHeating       bool
	isUnderPressure bool
	isWarm          bool
	keepWarm        bool
}

func (rc *RiceCooker) putRice(amount int) error {
	if rc.storage+amount > 10 {
		return errors.New("The maximum value is 10")
	}
	rc.storage += amount
	fmt.Printf("Added %d kg of rice to the storage.\n", amount)
	return nil
}

func (rc *RiceCooker) removeRice(amount int) error {
	if rc.storage-amount < 0 {
		return errors.New("Retrieving too much rice, 0 is the minimum level")
	}
	rc.storage -= amount
	fmt.Printf("Removed %d kg of rice from the storage.\n", rc.storage)
	return nil
}

func (rc *RiceCooker) putWater(amount int) error {
	if rc.waterStorage+amount > 10 {
		return errors.New("The maximum value is 10")
	}
	rc.waterStorage += amount
	fmt.Printf("Added %d L of water to the storage.\n", amount)
	return nil
}

func (rc *RiceCooker) removeWater(amount int) error {
	if rc.waterStorage-amount < 0 {
		return errors.New("0 is the minimum level")
	}
	fmt.Printf("Removed %d L of water from the storage.\n", rc.waterStorage)
	return nil
}

func (rc *RiceCooker) checkInside() {
	fmt.Printf("Rice Storage: %d kg\n", rc.storage)
	fmt.Printf("Water Storage: %d L\n", rc.waterStorage)
	fmt.Printf("Ingredient Basket: %d\n", rc.ingredients)
}

func (rc *RiceCooker) putIngredients(amount int) error {
	if rc.ingredients+amount > 5 {
		return errors.New("Ingredients limits is 5")
	}
	rc.ingredients += amount
	fmt.Println("Ingredients added to the steaming basket.")
	return nil
}

func (rc *RiceCooker) removeIngredients(amount int) error {
	if rc.ingredients-amount < 0 {
		return errors.New("You are taking past 0 ingredients")
	}
	rc.ingredients -= amount
	fmt.Println("Ingredients removed from the steaming basket.")
	return nil
}

func (rc *RiceCooker) setTimer(minutes int) error {
	if rc.storage > 0 || rc.ingredients > 0 {
		if !rc.powerOn {
			return errors.New("The rice cooker is plugged off")
		}
		if rc.isOpen {
			return errors.New("The rice cooker is open")
		}
		if rc.waterStorage == 0 {
			return errors.New("There is no water")
		}
		rc.timer = minutes
		fmt.Printf("Timer set for %d minutes.\n", minutes)
		for i := rc.timer; i <= 0; i-- {
			fmt.Printf("%d minutes.\n", i-1)
		}
		rc.timer = 0
		fmt.Printf("Finished\n")
	}
	fmt.Printf("There is nothing inside it")
	return nil
}

func main() {
	riceCooker := RiceCooker{}

	for {
		fmt.Println("\nOptions:")
		fmt.Println("1 - Plug In/Plug Out")
		fmt.Println("2 - Open/Close")
		fmt.Println("3 - Keep warm mode On/Off")
		fmt.Println("4 - Check status light")
		fmt.Println("5 - Put ingredients in the main storage")
		fmt.Println("6 - Put ingredients in the steaming basket")
		fmt.Println("7 - Set the timer")
		fmt.Println("8 - Exit")

		var choice int
		fmt.Print("Enter your choice: ")
		fmt.Scan(&choice)

		switch choice {
		case 1:
			if !riceCooker.powerOn {
				riceCooker.powerOn = true
				fmt.Print("Rice cooker is plugged in")
			} else if riceCooker.powerOn {
				riceCooker.powerOn = false
				fmt.Print("Rice cooker is plugged out")
			}
		case 2:
			if riceCooker.isOpen {
				riceCooker.isOpen = false
				fmt.Print("Rice cooker is closed")
			} else if !riceCooker.isOpen {
				riceCooker.isOpen = true
				fmt.Print("Rice cooker is opened")
			}
		case 3:
			if !riceCooker.keepWarm {
				riceCooker.keepWarm = true
				fmt.Print("Keep warm mode turned Off.")
			} else if riceCooker.keepWarm {
				riceCooker.keepWarm = false
				fmt.Print("Keep warm mode turned Off.")
			}
		case 4:
			if riceCooker.isHeating {
				fmt.Print("It is Heating")
			} else if riceCooker.isUnderPressure {
				fmt.Print("It is under pressure")
			} else if riceCooker.isWarm {
				fmt.Print("It is warm")
			} else {
				fmt.Println("Rice cooker is plugged out")
			}
		case 5:
			fmt.Println("\nOptions:")
			fmt.Println("1 - Put rice in the storage 10 kg")
			fmt.Println("2 - Remove rice in the storage")
			fmt.Println("3 - Put Water in the storage 10 L")
			fmt.Println("4 - Remove water in the storage")
			fmt.Println("5 - Check inside")
			fmt.Println("6 - Exit")

			var subChoice int
			fmt.Print("Enter your choice: ")
			fmt.Scan(&subChoice)

			switch subChoice {
			case 1:
				var amount int
				fmt.Print("Enter the amount of rice to put: ")
				fmt.Scan(&amount)
				riceCooker.putRice(amount)
			case 2:
				var amount int
				fmt.Print("Enter the amount of rice to retrieve: ")
				fmt.Scan(&amount)
				riceCooker.removeRice(amount)
			case 3:
				var amount int
				fmt.Print("Enter the amount of water to put: ")
				fmt.Scan(&amount)
				riceCooker.putWater(amount)
			case 4:
				var amount int
				fmt.Print("Enter the amount of water to retrieve: ")
				fmt.Scan(&amount)
				riceCooker.removeWater(amount)
			case 5:
				riceCooker.checkInside()
			case 6:
				continue
			default:
				fmt.Println("Invalid sub-choice.")
			}
		case 6:
			fmt.Println("\nOptions:")
			fmt.Println("1 - Put ingredients in it /4")
			fmt.Println("2 - Remove ingredients")
			fmt.Println("3 - Check inside")
			fmt.Println("4 - Exit")

			var subChoice int
			fmt.Print("Enter your choice: ")
			fmt.Scan(&subChoice)

			switch subChoice {
			case 1:
				var amount int
				fmt.Print("Enter the amount of ingredients to put: ")
				fmt.Scan(&amount)
				riceCooker.putIngredients(amount)
			case 2:
				var amount int
				fmt.Print("Enter the amount of ingredients to put: ")
				fmt.Scan(&amount)
				riceCooker.removeIngredients(amount)
			case 3:
				riceCooker.checkInside()
			case 4:
				continue
			default:
				fmt.Println("Invalid sub-choice.")
			}
		case 7:
			var minutes int
			fmt.Print("Enter the timer duration in minutes: ")
			fmt.Scan(&minutes)
			riceCooker.setTimer(minutes)
		case 8:
			fmt.Println("Exiting the virtual rice cooker.")
			return
		default:
			fmt.Println("Invalid choice.")
		}
	}
}

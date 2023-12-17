import 'dart:io';
import 'ingredient_basket.dart';
import 'Exception/lid_is_open.dart';
import 'Exception/no_ingredients.dart';
import 'Exception/no_more_rice.dart';
import 'Exception/no_more_water.dart';
import 'Exception/not_enough_water.dart';
import 'Exception/not_plugged_in.dart';
import 'Exception/too_much_water.dart';
import 'Exception/too_much_rice.dart';

class RiceCooker {
  int riceStorage = 0;
  int waterStorage = 0;
  int timer = 0;
  bool powerOn = false;
  bool isOpen = false;
  bool keepWarmMode = false;
  bool isHeating = false;
  bool isUnderPressure = false;
  bool isWarm = false;
  IngredientBasket steamingBasket = IngredientBasket();

  void plugIn() {
    print("Plugging in the rice cooker.");
    powerOn = true;
  }

  void plugOut() {
    print("Unplugging the rice cooker.");
    powerOn = false;
  }

  void open() {
    print("Opening the rice cooker.");
    isOpen = true;
  }

  void close() {
    print("Closing the rice cooker.");
    isOpen = false;
  }

  void toggleKeepWarmMode() {
    keepWarmMode = !keepWarmMode;
    print("Keep warm mode is ${keepWarmMode ? 'On' : 'Off'}.");
  }

  void checkStatusLight() {
    if(isHeating){
      print("It is heating");
    }
    else if(isUnderPressure){
      print("It is under pressure");
    }
    else if(isWarm){
      print("It is warming");
    }
    else {
      print("The rice cooker is off");
    }
  }
  void setTimer(int time){
    if(powerOn == false){
      throw NotPluggedIn("The rice cooker is plugged out");
    }
    if(riceStorage > 0 || steamingBasket.ingredients.length > 0){
      if(isOpen == true){
        throw LidIsOpen("The rice cooker is open");
      }
      if(waterStorage == 0){
        throw NotEnoughWater("There is no water");
      }
      timer = time;
      for (var i = time; i > 0; i--) {
        print(i.toString()+" minutes remaining...");
      }
      timer = 0;
      print("Finished"); 
    } else{
      throw NoIngredients("There is no ingredients in the storage");
    }
  }

  void displayOptions() {
    print("Options:");
    print("1 - Plug In/Plug Out");
    print("2 - Open/Close");
    print("3 - Keep warm mode On/Off");
    print("4 - Check status light");
    print("5 - Put ingredients in the main storage");
    print("6 - Put ingredients in the steaming basket");
    print("7 - Set the timer");
    print("8 - Exit");
  }

  void displayMainStorageOptions() {
    print("1 - Put rice in the storage 10 kg");
    print("2 - Remove rice in the storage");
    print("3 - Put water in the storage 10 L");
    print("4 - Remove water in the storage");
    print("5 - Check inside");
    print("6 - Exit");
  }

  void displaySteamingBasketOptions() {
    print("1 - Put ingredients in it");
    print("2 - Remove ingredients");
    print("3 - Check inside");
    print("4 - Exit");
  }


  void executeOption(int option) {
    switch (option) {
      case 1:
        powerOn ? plugOut() : plugIn();
        break;
      case 2:
        isOpen ? close() : open();
        break;
      case 3:
        toggleKeepWarmMode();
        break;
      case 4:
        checkStatusLight();
        break;
      case 5:
        print("Put ingredients in the main storage");
        displayMainStorageOptions();
        int mainStorageOption = int.parse(stdin.readLineSync()!);
        executeMainStorageOption(mainStorageOption);
        break;
      case 6:
        print("Put ingredients in the steaming basket");
        displaySteamingBasketOptions();
        int steamingBasketOption = int.parse(stdin.readLineSync()!);
        executeSteamingBasketOption(steamingBasketOption);
        break;
      case 7:
        print("Set the timer : ");
        int time = int.parse(stdin.readLineSync()!);
         try {
          setTimer(time);
        } catch (e) {
          print("Error : $e");
        }
        break;
      case 8:
        exit(0);
      default:
        print("Invalid option");
    }
  }
void addRice(int amount){
  if(riceStorage+amount > 10){
    throw TooMuchRice('You are adding too much rice, 10 is the maximum');
  }
  riceStorage += amount;
  print("You added "+amount.toString()+" kg of rice");
}
void removeRice(int amount){
  if(riceStorage-amount < 0){
    throw NoMoreRice("You are retrieving too much rice, 0 is the minimum");
  }
  riceStorage -= amount;
  print("You retrieved "+amount.toString()+" kg of rice");
}    
void addWater(int amount){
  if(waterStorage+amount > 10){
    throw TooMuchWater('You are adding too much water, 10 is the maximum');
  }
  waterStorage += amount;
  print("You added "+amount.toString()+" L of water");
} 
void removeWater(int amount){
  if(waterStorage-amount < 0){
    throw NoMoreWater("You are retrieving too much water, 0 is the minimum");
  }
  waterStorage -= amount;
  print("You retrieved "+amount.toString()+" L of water");
}   
void checkInside(){
  print("Currently, there is "+riceStorage.toString()+"kg of rice");
  print("Currently, there is "+waterStorage.toString()+"L of water");
}

  void executeMainStorageOption(int option) {
    switch (option) {
      case 1:
        print("Put rice in the main storage : ");
        int amount = int.parse(stdin.readLineSync()!);
        try {
          addRice(amount);
        } catch (e) {
          print("Error adding rice: $e");
        }
        break;
      case 2:
        print("Remove rice in the main storage : ");
        int amount = int.parse(stdin.readLineSync()!);
        try {
          removeWater(amount);
        } catch (e) {
          print("Error removing rice: $e");
        }
        break;
      case 3:
        print("Put water in the main storage : ");
        int amount = int.parse(stdin.readLineSync()!);
        try {
          addWater(amount);
        } catch (e) {
          print("Error adding water: $e");
        }
        break;
      case 4:
        print("Remove water in the main storage : ");
        int amount = int.parse(stdin.readLineSync()!);
        try {
          removeWater(amount);
        } catch (e) {
          print("Error removing water: $e");
        }
        break;
      case 5:
        checkInside();
        break;
      case 6:
        break;
      default:
        print("Invalid option");
    }
  }

  void executeSteamingBasketOption(int option) {
    switch (option) {
      case 1:
        print("Choose the name of the ingredient to add : ");
        String ingredient = stdin.readLineSync()!;
        try {
          steamingBasket.addIngredient(ingredient);
        } catch (e) {
          print("Error removing water: $e");
        }
        break;
      case 2:
        print("Choose the name of the ingredient to remove : ");
        String ingredient = stdin.readLineSync()!;
        try {
          steamingBasket.removeIngredient(ingredient);
        } catch (e) {
          print("Error removing water: $e");
        }
        break;
      case 3:
        steamingBasket.checkAllIngredients();
        break;
      case 4:
        break;
      default:
        print("Invalid option");
    }
  }
}

void main() {
  RiceCooker riceCooker = RiceCooker();

  while (true) {
    riceCooker.displayOptions();
    print("Choose a command : ");
    int option = int.parse(stdin.readLineSync()!);
    riceCooker.executeOption(option);
  }
}

import 'package:rice_cooker/exception/empty_basket.dart';
import 'package:rice_cooker/exception/lid_is_open.dart';
import 'package:rice_cooker/exception/no_ingredients.dart';
import 'package:rice_cooker/exception/no_more_space.dart';
import 'package:rice_cooker/exception/no_more_water.dart';
import 'package:rice_cooker/exception/no_more_rice.dart';
import 'package:rice_cooker/exception/not_enough_water.dart';
import 'package:rice_cooker/exception/not_plugged_in.dart';
import 'package:rice_cooker/exception/too_much_rice.dart';
import 'package:rice_cooker/exception/too_much_water.dart';
import 'package:rice_cooker/rice_cooker.dart';
import 'package:test/test.dart';

void main() {
  late RiceCooker riceCooker; 
  setUp(() {
    riceCooker = RiceCooker();
  });

  test('should plug in/out work', () {
    riceCooker.plugIn();
    expect(riceCooker.powerOn, isTrue);
    riceCooker.plugOut();
    expect(riceCooker.powerOn, isFalse);
  });

  test('toggleKeepWarmMode should toggle keep warm mode', () {
    riceCooker.toggleKeepWarmMode();
    expect(riceCooker.keepWarmMode, isTrue);
    riceCooker.toggleKeepWarmMode();
    expect(riceCooker.keepWarmMode, isFalse);
  });

  test('check light status', () {
    riceCooker.isHeating = true;
    expect(riceCooker.checkStatusLight(), "It is heating");
    riceCooker.isHeating = false;
    riceCooker.isUnderPressure = true;
    expect(riceCooker.checkStatusLight(), "It is under pressure");
    riceCooker.isUnderPressure = false;
    riceCooker.isWarm = true;
    expect(riceCooker.checkStatusLight(), "It is warming");
    riceCooker.isWarm = false;
    expect(riceCooker.checkStatusLight(), "The rice cooker is off");
  });

  test('should add rice to storage', () {
    riceCooker.addRice(5);
    expect(riceCooker.riceStorage, equals(5));
  });

  test('should throw TooMuchRice when adding too much rice', () {
    expect(() => riceCooker.addRice(11), throwsA(isA<TooMuchRice>()));
  });

  test('should add water to storage', () {
    riceCooker.addWater(5);
    expect(riceCooker.waterStorage, equals(5));
  });

  test('should throw TooMuchWater when adding too much water', () {
    expect(() => riceCooker.addWater(11), throwsA(isA<TooMuchWater>()));
  });

  test('should remove rice to storage', () {
    riceCooker.addRice(5);
    riceCooker.removeRice(4);
    expect(riceCooker.riceStorage, equals(1));
  });
  test('should throw NoMoreRice when removing too much rice', () {
    expect(() => riceCooker.removeRice(11), throwsA(isA<NoMoreRice>()));
  });

  test('should remove water to storage', () {
    riceCooker.addWater(5);
    riceCooker.removeWater(4);
    expect(riceCooker.waterStorage, equals(1));
  });

  test('should throw NoMoreWater when removing too much water', () {
    expect(() => riceCooker.removeWater(11), throwsA(isA<NoMoreWater>()));
  });

  test('check inside storage', () {
    expect(riceCooker.checkInside(), """
  Currently, there is 0kg of rice
  Currently, there is 0L of water
  """);
  });

  test('should add ingredients in the basket', () {
    riceCooker.steamingBasket.addIngredient("tomato");
    expect(riceCooker.steamingBasket.ingredients.contains("tomato"),true);
  });

  test('should throw NoMoreSpace', () {
    riceCooker.steamingBasket.addIngredient("tomato");
    riceCooker.steamingBasket.addIngredient("salad");
    riceCooker.steamingBasket.addIngredient("meat");
    riceCooker.steamingBasket.addIngredient("fruit");
    expect(() => riceCooker.steamingBasket.addIngredient("something"), throwsA(isA<NoMoreSpace>()));
  });

  test('should remove ingredients in the basket', () {
    riceCooker.steamingBasket.addIngredient("tomato");
    riceCooker.steamingBasket.removeIngredient("tomato");
    expect(riceCooker.steamingBasket.ingredients.contains("tomato"),false);
  });
  test('should throw EmptyBasket when empty', () {
    expect(() => riceCooker.steamingBasket.removeIngredient("tomato"), throwsA(isA<EmptyBasket>()));
  });

  test('check all ingredients (empty)', () {
    expect(riceCooker.steamingBasket.checkAllIngredients(), "Ingredient basket is empty.");
  });

  test('check all ingredients', () {
    riceCooker.steamingBasket.addIngredient("tomato");
    expect(riceCooker.steamingBasket.checkAllIngredients(), "Ingredients in the basket: tomato");
  });

  test('set the timer (not plugged in)', () {
    expect(() => riceCooker.setTimer(11), throwsA(isA<NotPluggedIn>()));
  });

  test('set the timer (empty)', () {
    riceCooker.powerOn = true;
    expect(() => riceCooker.setTimer(11), throwsA(isA<NoIngredients>()));
  });

  test('set the timer (LidOpen)', () {
    riceCooker.powerOn = true;
    riceCooker.isOpen = true;
    riceCooker.riceStorage = 5;
    expect(() => riceCooker.setTimer(11), throwsA(isA<LidIsOpen>()));
  });

  test('set the timer (NoWater)', () {
    riceCooker.powerOn = true;
    riceCooker.riceStorage = 5;
    expect(() => riceCooker.setTimer(11), throwsA(isA<NotEnoughWater>()));
  });

  test('set the timer (LidOpen)', () {
    riceCooker.powerOn = true;
    riceCooker.riceStorage = 5;
    riceCooker.waterStorage = 5;
    expect(riceCooker.setTimer(11), "Finished");
    });
}

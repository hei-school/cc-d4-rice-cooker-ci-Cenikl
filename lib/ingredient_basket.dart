
import 'exception/no_more_space.dart';
import 'exception/empty_basket.dart';

class IngredientBasket {
  List<String> ingredients = [];

  void addIngredient(String ingredient) {
    if(ingredients.length > 3){
      throw NoMoreSpace("The basket is full");
    }
    ingredients.add(ingredient);
    print("You added $ingredient to the basket");
  }

  void removeIngredient(String ingredient) {
    if(ingredients.isEmpty){
      throw EmptyBasket("The basket is empty");
    } else {
      ingredients.remove(ingredient);
      print("You removed $ingredient to the basket");
    }
  }

  String checkAllIngredients() {
    if (ingredients.isEmpty) {
      return("Ingredient basket is empty.");
    } else {
      return("Ingredients in the basket: ${ingredients.join(', ')}");
    }
  }
}
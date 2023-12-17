import 'Exception/not_more_space.dart';
import 'Exception/empty_basket.dart';
class IngredientBasket {
  List<String> ingredients = [];

  void addIngredient(String ingredient) {
    if(ingredients.length > 3){
      throw NotMoreSpace("The basket is full");
    }
    ingredients.add(ingredient);
    print("You added "+ingredient+" to the basket");
  }

  void removeIngredient(String ingredient) {
    if(ingredients.length == 0){
      throw EmptyBasket("The basket is empty");
    }
    ingredients.remove(ingredient);
    print("You removed "+ingredient+" to the basket");
  }

  void checkAllIngredients() {
    if (ingredients.isEmpty) {
      print("Ingredient basket is empty.");
    } else {
      print("Ingredients in the basket: ${ingredients.join(', ')}");
    }
  }
}
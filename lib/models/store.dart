import '../dummy/meals.dart';
import '../models/meal.dart';

class Store {
  Map<String, bool>? appliedFilters;
  List<Meal>? availableMeals;
  List<Meal>? favoriteMeals;

  Store() {
    appliedFilters = {
      'gluten-free': false,
      'lactose-free': false,
      'vegan': false,
      'vegetarian': false,
    };
    availableMeals = DUMMY_MEALS.toList();
    favoriteMeals = [];
  }
}

import '../models/store.dart';
import '../store/index.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/categoryMeals.dart';

class Favorites extends StatefulWidget {
  static const String routeName = '/favorites';

  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  void removeMeal(String mealId, Store store) {
    setState(() {
      store.availableMeals!.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreContainer.of(context);
    final List<Meal>? favoriteMeals = store.favoriteMeals;

    return favoriteMeals!.isEmpty
        ? const Center(
            child: Text('You have no favorite yet - start adding same!'),
          )
        : ListView.builder(
            itemBuilder: (_, index) => CategoryMealItem(
              meal: favoriteMeals[index],
              removeMeal: (String mealId) {
                removeMeal(mealId, store);
              },
            ),
            itemCount: favoriteMeals.length,
          );
  }
}

// ! is a syntatic sugar for (functionName as FunctionType).call(parameters);
// ?? if nulls it returns the RHS value;
// ?. null-aware access (if null return null and not going to access RHS properties) 
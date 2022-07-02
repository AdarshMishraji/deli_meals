import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/categoryMeals.dart';

class Favorites extends StatelessWidget {
  static const String routeName = '/favorites';

  final List<Meal> favoriteMeals;

  const Favorites({Key? key, required this.favoriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? const Center(
            child: Text('You have no favorite yet - start adding same!'),
          )
        : ListView.builder(
            itemBuilder: (_, index) => CategoryMealItem(
              meal: favoriteMeals[index],
              removeMeal: () {},
            ),
            itemCount: favoriteMeals.length,
          );
  }
}

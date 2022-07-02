import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../dummy/meals.dart';
import '../screens/categories.dart';
import '../screens/mealDetail.dart';
import '../screens/categoryMeals.dart';
import '../screens/filters.dart';
import '../screens/main.dart';

void main() {
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  Map<String, bool> _filters = {
    'gluten-free': false,
    'lactose-free': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where(
        (element) {
          if (_filters['gluten-free'] != null && !element.isGlutenFree) {
            return false;
          }
          if (_filters['lactose-free'] != null && !element.isLactoseFree) {
            return false;
          }
          if (_filters['vegan'] != null && !element.isVegan) {
            return false;
          }
          if (_filters['vegetarian'] != null && !element.isVegetarian) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  void _toggleFavorite(String mealId) {
    final index = _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (index == -1) {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    } else {
      setState(() {
        _favoriteMeals.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium:
                  const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              labelMedium:
                  const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: CategoriesScreen.routeName,
      routes: {
        MainScreen.routeName: (context) =>
            MainScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavorite: _toggleFavorite, isMealFavorite: _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(saveFilters: _setFilters, appliedFilters: _filters),
      },
      // onGenerateRoute: (settings) {
      //   // this is a callback, called when there is a routing happens, if there is no route registered for the route name, the returned Route from this function used.
      //   // this can also be used for the case when there are dynamic route generated, and we need to show a particular widget.
      //   return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      // },

      // onUnknownRoute: (settings) {
      //   // this is called when there is no widget returned by any measure.
      //   // like 404 page
      //   return MaterialPageRoute(builder: (_) => const MainScreen());
      // },
    );
  }
}

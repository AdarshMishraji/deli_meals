import 'package:flutter/material.dart';

import '../models/store.dart';
import '../store/index.dart';
import '../screens/categories.dart';
import '../screens/mealDetail.dart';
import '../screens/categoryMeals.dart';
import '../screens/filters.dart';
import '../screens/main.dart';

void main() {
  runApp(StoreContainer(
    store: Store(),
    child: const Root(),
  ));
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

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
        MainScreen.routeName: (context) => const MainScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FiltersScreen.routeName: (context) => const FiltersScreen(),
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

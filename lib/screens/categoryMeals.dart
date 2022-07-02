import 'package:flutter/material.dart';

import '../store/index.dart';
import '../models/meal.dart';
import '../models/store.dart';
import '../screens/mealDetail.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meal';

  const CategoryMealsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  void removeMeal(String mealId, Store store) {
    setState(() {
      store.availableMeals!.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String? categoryTitle = routeArgs['title'];
    final store = StoreContainer.of(context);
    final List<Meal>? categoryMeals = store.availableMeals
        ?.where((element) => element.categories.contains(routeArgs['id']))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle ?? ''),
      ),
      body: Center(
        child: ((categoryMeals?.length ?? 0) > 0)
            ? ListView.builder(
                itemCount: categoryMeals?.length,
                itemBuilder: (_, index) {
                  return CategoryMealItem(
                    key: ValueKey(categoryMeals![index].id),
                    meal: categoryMeals[index],
                    removeMeal: (mealId) => removeMeal(mealId, store),
                  );
                },
              )
            : Container(),
      ),
    );
  }
}

class CategoryMealItem extends StatelessWidget {
  final Meal meal;
  final Function removeMeal;
  const CategoryMealItem(
      {Key? key, required this.meal, required this.removeMeal})
      : super(key: key);

  String get getComplexity {
    switch (meal.complexity) {
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
      case Complexity.simple:
        return 'Simple';
      default:
        return 'Unknown';
    }
  }

  String get getAffordability {
    switch (meal.affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.luxurious:
        return 'Luxurious';
      case Affordability.pricey:
        return 'Pricey';
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: meal.id)
        .then(
      // then is called after page umounted after mounted state. (after popped)
      // not only for this method, but also for any push method.
      (value) {
        if (value != null) removeMeal(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 300,
                    color: Colors.black54,
                    child: Text(
                      meal.title,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('${meal.duration} min'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(getComplexity),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(getAffordability),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

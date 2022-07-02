import '../models/store.dart';
import '../store/index.dart';
import 'package:flutter/material.dart';

import '../dummy/meals.dart';

class MealDetailScreen extends StatefulWidget {
  static const String routeName = '/mealDetail';

  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  void toggleFavorite(String mealId, Store store) {
    final index =
        store.favoriteMeals!.indexWhere((element) => element.id == mealId);
    if (index == -1) {
      setState(() {
        store.favoriteMeals!
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    } else {
      setState(() {
        store.favoriteMeals!.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)?.settings.arguments as String;
    final store = StoreContainer.of(context);
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    final isFavorite =
        store.favoriteMeals!.any((element) => element.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(meal.id),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            BuildItems(title: 'Ingredients', items: meal.ingredients),
            const Divider(),
            BuildItems(
              title: 'Steps',
              items: meal.steps,
              showIndex: true,
              showBackground: false,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(meal.id);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child:
            Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
        onPressed: () => toggleFavorite(mealId, store),
      ),
    );
  }
}

class BuildItems extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool? showIndex;
  final bool showBackground;
  const BuildItems({
    Key? key,
    required this.title,
    required this.items,
    this.showIndex,
    this.showBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(
              10,
            ),
            itemCount: items.length,
            itemBuilder: (_, index) {
              return Card(
                color: showBackground ? Colors.blueAccent : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    if (showIndex == true)
                      CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          '# ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: showIndex == true ? 10 : 0),
                        child: Text(
                          items[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

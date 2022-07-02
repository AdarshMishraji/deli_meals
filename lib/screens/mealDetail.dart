import 'package:flutter/material.dart';

import '../dummy/meals.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/mealDetail';

  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealDetailScreen(
      {Key? key, required this.toggleFavorite, required this.isMealFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    final isFavorite = isMealFavorite(mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
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
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}

class BuildItems extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool? showIndex;
  final bool showBackground;
  const BuildItems(
      {Key? key,
      required this.title,
      required this.items,
      this.showIndex,
      this.showBackground = true})
      : super(key: key);

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

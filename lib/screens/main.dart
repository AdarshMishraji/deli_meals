import 'package:flutter/material.dart';

import '../screens/categories.dart';
import '../screens/favorites.dart';
import '../screens/filters.dart';
import '../models/meal.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  final List<Meal> favoriteMeals;

  const MainScreen({Key? key, required this.favoriteMeals}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // ********* this is for top bars ************
  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //         appBar: AppBar(
  //           title: Text('Meals'),
  //           bottom: const TabBar(tabs: [
  //             Tab(
  //               icon: Icon(Icons.category),
  //               text: 'Categories',
  //             ),
  //             Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
  //           ]),
  //         ),
  //         body: const TabBarView(
  //           children: [CategoriesScreen(), Favorites()],
  //         )),
  //   );
  // }

  late List<Map<String, dynamic>> _pages;
  int _selectedPage = 0;

  void _selectPage(int index) {
    setState(
      () => _selectedPage = index,
    );
  }

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {
        'page': Favorites(favoriteMeals: widget.favoriteMeals),
        'title': 'Your Favorites'
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPage]['title'] as String),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectPage,
        currentIndex: _selectedPage,
        // type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
      body: _pages[_selectedPage]['page'] as Widget,
      drawer: const MainDrawer(),
    );
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
      {required String title,
      required IconData icon,
      required VoidCallback onTapCallback}) {
    return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onTap: onTapCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColorLight,
            child: const Text('Deli Meals',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(
              title: 'Meals',
              icon: Icons.restaurant,
              onTapCallback: () {
                Navigator.of(context)
                    .pushReplacementNamed(MainScreen.routeName);
              }),
          buildListTile(
              title: 'Filters',
              icon: Icons.settings,
              onTapCallback: () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              }),
        ],
      ),
    );
  }
}

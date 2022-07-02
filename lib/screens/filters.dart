import 'package:deli_meals/screens/main.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> appliedFilters;

  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.appliedFilters})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false,
      _lactoseFree = false,
      _vegan = false,
      _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.appliedFilters['gluten-free'] ?? false;
    _lactoseFree = widget.appliedFilters['lactose-free'] ?? false;
    _vegan = widget.appliedFilters['vegan'] ?? false;
    _vegetarian = widget.appliedFilters['vegetarian'] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final Map<String, bool> filters = {
                  'gluten-free': _glutenFree,
                  'lactose-free': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(filters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal section',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  value: _glutenFree,
                  onChanged: (flag) {
                    setState(() {
                      _glutenFree = flag;
                    });
                  },
                  title: const Text('Gluten-Free'),
                  subtitle: const Text('Only includes gluten-free meals'),
                ),
                SwitchListTile(
                  value: _lactoseFree,
                  onChanged: (flag) {
                    setState(() {
                      _lactoseFree = flag;
                    });
                  },
                  title: const Text('Lactose-Free'),
                  subtitle: const Text('Only includes lactose-free meals'),
                ),
                SwitchListTile(
                  value: _vegan,
                  onChanged: (flag) {
                    setState(() {
                      _vegan = flag;
                    });
                  },
                  title: const Text('Vegan'),
                  subtitle: const Text('Only includes vegan meals'),
                ),
                SwitchListTile(
                  value: _vegetarian,
                  onChanged: (flag) {
                    setState(() {
                      _vegetarian = flag;
                    });
                  },
                  title: const Text('Vegetarian'),
                  subtitle: const Text('Only includes vegetarian meals'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

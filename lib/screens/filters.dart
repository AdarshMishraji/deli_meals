import '../screens/main.dart';
import '../store/index.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    final storeProvider = StoreContainer.of(context);
    final Map<String, bool>? appliedFilters = storeProvider.appliedFilters;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
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
                  value: appliedFilters!['gluten-free'] ?? false,
                  onChanged: (flag) {
                    setState(() {
                      storeProvider.appliedFilters!['gluten-free'] = flag;
                    });
                  },
                  title: const Text('Gluten Free'),
                  subtitle: const Text('Only includes gluten-free meals'),
                ),
                SwitchListTile(
                  value: appliedFilters['lactose-free'] ?? false,
                  onChanged: (flag) {
                    setState(() {
                      storeProvider.appliedFilters!['lactose-free'] = flag;
                    });
                  },
                  title: const Text('Lactose Free'),
                  subtitle: const Text('Only includes lactose-free meals'),
                ),
                SwitchListTile(
                  value: appliedFilters['vegan'] ?? false,
                  onChanged: (flag) {
                    setState(() {
                      storeProvider.appliedFilters!['vegan'] = flag;
                    });
                  },
                  title: const Text('Vegan'),
                  subtitle: const Text('Only includes vegan meals'),
                ),
                SwitchListTile(
                  value: appliedFilters['vegetarian'] ?? false,
                  onChanged: (flag) {
                    setState(() {
                      storeProvider.appliedFilters!['vegetarian'] = flag;
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

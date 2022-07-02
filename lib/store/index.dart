import '../dummy/meals.dart';
import 'package:flutter/material.dart';

import '../models/store.dart';

class StoreContainer extends InheritedWidget {
  final Store store;
  const StoreContainer({Key? key, required Widget child, required this.store})
      : super(key: key, child: child);

  static Store of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoreContainer>()!.store;
  }

  @override
  bool updateShouldNotify(StoreContainer oldWidget) {
    return true;
  }
}

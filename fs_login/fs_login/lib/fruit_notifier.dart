import 'dart:collection';

import 'package:fs_login/fruit.dart';
import 'package:flutter/cupertino.dart';

class FruitNotifier with ChangeNotifier {
  List<Fruit> _fruitList = [];
  Fruit _currentFruit;

  UnmodifiableListView<Fruit> get fruitList => UnmodifiableListView(_fruitList);

  Fruit get currentFruit => _currentFruit;

  set fruitList(List<Fruit> fruitList) {
    _fruitList = fruitList;
    notifyListeners();
  }

  set currentFruit(Fruit fruit) {
    _currentFruit = fruit;
    notifyListeners();
  }

  addFood(Fruit fruit) {
    _fruitList.insert(0, fruit);
    notifyListeners();
  }

}
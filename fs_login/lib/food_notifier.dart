import 'dart:collection';

import 'package:fs_login/food.dart';
import 'package:flutter/cupertino.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _fruitList = [];
  Food _currentFruit;

  UnmodifiableListView<Food> get fruitList => UnmodifiableListView(_fruitList);

  Food get currentFruit => _currentFruit;

  set fruitList(List<Food> fruitList) {
    _fruitList = fruitList;
    notifyListeners();
  }

  set currentFruit(Food fruit) {
    _currentFruit = fruit;
    notifyListeners();
  }

  addFood(Food fruit) {
    _fruitList.insert(0, fruit);
    notifyListeners();
  }

}
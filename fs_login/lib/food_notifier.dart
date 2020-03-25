import 'dart:collection';

import 'package:fs_login/food.dart';
import 'package:flutter/cupertino.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _foodList = [];
  Food _currentFood;
  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);
  Food get currentFood => _currentFood;
  set foodList(List<Food> foodList) {
    _foodList = foodList;
    notifyListeners();
  }
  set currentFood(Food food) {
    _currentFood = food;
    notifyListeners();
  }
  addFood(Food food) {
    _foodList.insert(0, food);
    notifyListeners();
  }



  List<Food> _vegetableList = [];
  Food _currentVegetable;
  UnmodifiableListView<Food> get vegetableList =>
      UnmodifiableListView(_vegetableList);
  Food get currentVegetable => _currentVegetable;
  set vegetableList(List<Food> vegetableList) {
    _vegetableList = _vegetableList;
    notifyListeners();
  }
  set currentVegetable(Food vegetable) {
    _currentVegetable = vegetable;
    notifyListeners();
  }
  addVegetable(Food vegetable) {
    _vegetableList.insert(0, vegetable);
    notifyListeners();
  }


  List<Food> _proteinList = [];
  Food _currentProtein;
  UnmodifiableListView<Food> get proteinList =>
      UnmodifiableListView(_proteinList);
  Food get currentProtein => _currentProtein;
  set proteinList(List<Food> proteinList) {
    _proteinList = proteinList;
    notifyListeners();
  }
  set currentProtein(Food protein) {
    _currentProtein = protein;
    notifyListeners();
  }
  addProtein(Food protein) {
    _proteinList.insert(0, protein);
    notifyListeners();
  }



  List<Food> _breadList = [];
  Food _currentBread;
  UnmodifiableListView<Food> get breadList => UnmodifiableListView(_breadList);
  Food get currentBread => _currentBread;
  set breadList(List<Food> breadList) {
    _breadList = breadList;
    notifyListeners();
  }
  set currentBread(Food bread) {
    _currentBread = bread;
    notifyListeners();
  }
  addBread(Food bread) {
    _breadList.insert(0, bread);
    notifyListeners();
  }


  List<Food> _frozenList = [];
  Food _currentFrozen;
  UnmodifiableListView<Food> get frozenList => UnmodifiableListView(_frozenList);
  Food get currentFrozen => _currentFrozen;
  set frozenList(List<Food> frozenList) {
    _frozenList = frozenList;
    notifyListeners();
  }
  set currentFrozen(Food frozen) {
    _currentFrozen = frozen;
    notifyListeners();
  }
  addFrozen(Food frozen) {
    _frozenList.insert(0, frozen);
    notifyListeners();
  }
}

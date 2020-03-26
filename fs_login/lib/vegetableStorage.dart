import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';

class Vegetablestorage extends StatefulWidget {
  @override
  _VegetableStorage createState() => _VegetableStorage();
}

class _VegetableStorage extends State<Vegetablestorage> {
  @override
  void initState() {
    FoodNotifier vegetableNotifier =
    Provider.of<FoodNotifier>(context, listen: false);
    getProtein(vegetableNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier vegetableNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetable List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(), fullscreenDialog: true)),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
                "ItemName: " + vegetableNotifier.vegetableList[index].itemname),
            subtitle: Text(
                "Provider Name: " + vegetableNotifier.vegetableList[index].pname),
          );
        },
        itemCount: vegetableNotifier.vegetableList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
      ),
    );
  }
}

getProtein(FoodNotifier vegetableNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Category')
      .document('FoodCategory')
      .collection('Vegetable')
      .getDocuments();

  List<Food> _vegetableList = [];
  snapshot.documents.forEach((document) {
    Food vegetable = Food.fromMap(document.data);
    _vegetableList.add(vegetable);
  });

  vegetableNotifier.proteinList = _vegetableList;
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';

class Proteinstorage extends StatefulWidget {
  @override
  _ProteinStorage createState() => _ProteinStorage();
}

class _ProteinStorage extends State<Proteinstorage> {
  @override
  void initState() {
    FoodNotifier proteinNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getProtein(proteinNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier proteinNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Protein List'),
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
                "ItemName: " + proteinNotifier.proteinList[index].itemname),
            subtitle: Text(
                "Provider Name: " + proteinNotifier.proteinList[index].pname),
          );
        },
        itemCount: proteinNotifier.proteinList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
      ),
    );
  }
}

getProtein(FoodNotifier proteinNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Protein')
      .document('proteintorage')
      .collection('Beef')
      .getDocuments();

  List<Food> _proteinList = [];
  snapshot.documents.forEach((document) {
    Food fruit = Food.fromMap(document.data);
    _proteinList.add(fruit);
  });

  proteinNotifier.proteinList = _proteinList;
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Fruit {
  String itemname;
  String pname;

  Fruit();

  Fruit.fromMap(Map<String, dynamic> data) {
    itemname = data['ItemName'];
    pname = data['PName'];

  }

  Map<String, dynamic> toMap() {
    return {
      'ItemName': itemname,
      'PName': pname,

    };
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String itemname;
  String pname;

  Food();

  Food.fromMap(Map<String, dynamic> data) {
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
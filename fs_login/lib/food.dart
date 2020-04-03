//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:intl/intl.dart';

class Food {
  String itemname;
  String pname;
  DateTime startDate;
  DateTime endDate;
  String imagePath;
  bool reserved;

  Food(

      );

  Food.fromMap(Map<String, dynamic> data) {
    itemname = data['ItemName'];
    pname = data['PName'];
    startDate = data['StartDate'].toDate();
    endDate = data['EndDate'].toDate();
    imagePath = data['ImagePath'];
    reserved = data['Reserved'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ItemName': itemname,
      'PName': pname,
      'StartDate': startDate,
      'EndDate': endDate,
      'ImagePath': imagePath,
      'Reserved': reserved,
    };
  }
}
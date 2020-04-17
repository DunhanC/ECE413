//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Food {
  String itemname;
  int quantity;
  String address;
  DateTime startDate;
  DateTime endDate;
  String imagePath;
  bool reserved;
  GeoPoint coordinates;
  Food(

      );

  Food.fromMap(Map<String, dynamic> data) {
    itemname = data['ItemName'];
    quantity = data['Quantity'];
    address = data['Address'];
    startDate = data['StartDate'].toDate();
    endDate = data['EndDate'].toDate();
    imagePath = data['ImagePath'];
    reserved = data['Reserved'];
    coordinates = GeoPoint(data['Coordinate'].latitude, data['Coordinate'].longitude);
  }

  Map<String, dynamic> toMap() {
    return {
      'ItemName': itemname,
      'Quantity': quantity,
      'Address': address,
      'StartDate': startDate,
      'EndDate': endDate,
      'ImagePath': imagePath,
      'Reserved': reserved,
      'Coordinate': coordinates
    };
  }
}
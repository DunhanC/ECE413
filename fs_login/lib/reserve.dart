import 'package:flutter/material.dart';
import 'package:fs_login/Pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'dart:io';
class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  @override
  void initState(){

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getFood(foodNotifier);
    super.initState();
  }
  File imageFile;
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Reservation"),
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),

      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Image.network(foodNotifier.foodList[index].imagePath),
            title: Text("Item: " + foodNotifier.foodList[index].itemname),
            subtitle: Text("Name: " + foodNotifier.foodList[index].pname),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Reserve'),
              onPressed: () async{

              },
            ),
          );

        },
        itemCount: foodNotifier.foodList.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider(color: Colors.black,
          );


        },

      ),
    );
  }
}
getFood(FoodNotifier foodNotifier) async{

  QuerySnapshot snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Fruit').getDocuments();

  List<Food> _foodList = [];
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });
  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Frozen').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });
  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Drink').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });
  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Protein').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });
  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Seafood').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });
  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Canned').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);
  });

  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Bread').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });
  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Vegetable').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });

  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Instant').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });
  snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Dessert').getDocuments();
  snapshot.documents.forEach((document){

    Food allfood = Food.fromMap(document.data);
    _foodList.add(allfood);

  });


  foodNotifier.foodList = _foodList;
}


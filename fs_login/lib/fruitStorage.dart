import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';
import 'dart:io';
import 'package:fs_login/Pages/BottomNavigation/naviHome.dart';
class Fruitstorage extends StatefulWidget{
  @override
  _FruitStorage createState()=> _FruitStorage();

}


class _FruitStorage extends State<Fruitstorage> {

  List<String> _documentID = [];

  @override
  void initState(){

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getFruits(foodNotifier);
    super.initState();
  }
  File imageFile;
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Fruit List'),
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
              onPressed: () {
                print(_documentID[index]);
                  Firestore.instance.collection('Category').document('FoodCategory').collection('Fruit')
                      .document(_documentID[index]).updateData({'Reserved':true});
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NHome(),fullscreenDialog: true));
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

  getFruits(FoodNotifier foodNotifier) async{

    QuerySnapshot snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Fruit').getDocuments();

    List<Food> _foodList = [];
    snapshot.documents.forEach((document){
      if(!document.data['Reserved']) {
        Food fruit = Food.fromMap(document.data);
        _foodList.add(fruit);
        print(document.documentID);
        _documentID.add(document.documentID);
      }
    });


    foodNotifier.foodList = _foodList;
  }

}




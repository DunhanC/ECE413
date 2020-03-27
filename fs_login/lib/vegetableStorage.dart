import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';
import 'dart:io';

class Vegetablestorage extends StatefulWidget{
  @override
  _VegetableStorage createState()=> _VegetableStorage();

}


class _VegetableStorage extends State<Vegetablestorage> {

  @override
  void initState(){

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getVegetable(foodNotifier);
    super.initState();
  }
  File imageFile;
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Vegetable List'),
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

getVegetable(FoodNotifier foodNotifier) async{

  QuerySnapshot snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Vegetable').getDocuments();

  List<Food> _foodList = [];
  snapshot.documents.forEach((document){

    Food vegetable = Food.fromMap(document.data);
    _foodList.add(vegetable);

  });


  foodNotifier.foodList = _foodList;
}


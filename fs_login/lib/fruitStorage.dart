import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';

class Fruitstorage extends StatefulWidget{
  @override
  _FruitStorage createState()=> _FruitStorage();

}

class _FruitStorage extends State<Fruitstorage> {

  @override
  void initState(){

    FoodNotifier fruitNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getFruits(fruitNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier fruitNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(

        title: Text('Fruit List'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),

      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text("ItemName: " + fruitNotifier.fruitList[index].itemname),
            subtitle: Text("Provider Name: " + fruitNotifier.fruitList[index].pname),


          );

        },
        itemCount: fruitNotifier.fruitList.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider(color: Colors.black,
          );


        },

      ),



    );
  }
}

getFruits(FoodNotifier fruitNotifier) async{
  
  QuerySnapshot snapshot = await Firestore.instance.collection('Fruit').document('fruitstorage').collection('Apple').getDocuments();

  List<Food> _fruitList = [];
  snapshot.documents.forEach((document){

    Food fruit = Food.fromMap(document.data);
    _fruitList.add(fruit);

  });

  fruitNotifier.fruitList = _fruitList;
}


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';

class Breadstorage extends StatefulWidget{
  @override
  _BreadStorage createState()=> _BreadStorage();

}

class _BreadStorage extends State<Breadstorage> {

  @override
  void initState(){

    FoodNotifier BreadNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getBread(BreadNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier breadNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(

        title: Text('Bread List'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),

      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text("ItemName: " + breadNotifier.breadList[index].itemname),
            subtitle: Text("Provider Name: " + breadNotifier.breadList[index].pname),


          );

        },
        itemCount: breadNotifier.breadList.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider(color: Colors.black,
          );


        },

      ),



    );
  }
}

getBread(FoodNotifier breadNotifier) async{

  QuerySnapshot snapshot = await Firestore.instance.collection('Bread').document('breadstorage').collection('Apple').getDocuments();

  List<Food> _breadList = [];
  snapshot.documents.forEach((document){

    Food bread = Food.fromMap(document.data);
    _breadList.add(bread);

  });

  breadNotifier.breadList = _breadList;
}


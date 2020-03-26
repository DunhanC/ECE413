import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';

class Frozenstorage extends StatefulWidget{
  @override
  _FrozenStorage createState()=> _FrozenStorage();

}

class _FrozenStorage extends State<Frozenstorage> {

  @override
  void initState(){

    FoodNotifier frozenNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getFruits(frozenNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier frozenNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(

        title: Text('Frozen Food List'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),

      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text("ItemName: " + frozenNotifier.frozenList[index].itemname),
            subtitle: Text("Provider Name: " + frozenNotifier.frozenList[index].pname),


          );

        },
        itemCount: frozenNotifier.frozenList.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider(color: Colors.black,
          );


        },

      ),



    );
  }
}

getFruits(FoodNotifier frozenNotifier) async{

  QuerySnapshot snapshot = await Firestore.instance.collection('Frozen Food').document('frozenstorage').collection('Apple').getDocuments();

  List<Food> _frozenList = [];
  snapshot.documents.forEach((document){

    Food frozen = Food.fromMap(document.data);
    _frozenList.add(frozen);

  });

  frozenNotifier.foodList = _frozenList;
}


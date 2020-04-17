import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  @override
  void initState(){

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getFrozen(foodNotifier);
    super.initState();
  }
  File imageFile;
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Order List'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),

      body: ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: (){

              },
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Container(
                            width: 250,
                            height: 160,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.fill,
                                alignment: Alignment.topLeft,
                                image: NetworkImage(
                                    foodNotifier.foodList[index].imagePath
                                ),
                              ),
                            ),
                          ),

                          VerticalDivider(

                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer(foodNotifier, index),
                            ),
                          ),
                          VerticalDivider(

                          ),

                        ],
                      )
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: foodNotifier.foodList.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider(color: Colors.transparent,
          );
        },

      ),
    );
  }
  Widget myDetailsContainer(FoodNotifier foodNotifier, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text(foodNotifier.foodList[index].itemname,
            style: TextStyle(color: Colors.redAccent, fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text('Quantity: ' + foodNotifier.foodList[index].quantity.toString(),
            style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
        ),
        /*
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(child: Text("4.3",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStarHalf, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Text(" \u00B7  mi",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                ],)),
        ),
        */
        Container(child: Text("Coral Gables, FL",
          style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
      ],
    );
  }
}

getFrozen(FoodNotifier foodNotifier) async{

  QuerySnapshot snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Fruit').getDocuments();

  List<Food> _foodList = [];
  snapshot.documents.forEach((document){
    if(document.data['Reserved']) {
      Food fruit = Food.fromMap(document.data);
      _foodList.add(fruit);
    }
  });


  foodNotifier.foodList = _foodList;
}

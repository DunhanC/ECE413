import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fs_login/Counter.dart';
import 'package:fs_login/main.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';
import 'package:fs_login/Pages/home.dart';
import 'dart:io';
import 'package:fs_login/Pages/BottomNavigation/naviHome.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;
class Dessertstorage extends StatefulWidget{
  @override
  _DessertStorage createState()=> _DessertStorage();

}

class _DessertStorage extends State<Dessertstorage> {

  List<String> _documentID = [];
  DateTime _dateTime = DateTime.now();
  List<double> _distance = [];

  @override
  void initState(){

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getDesserts(foodNotifier);
    super.initState();
  }
  File imageFile;
  var quantities;

  Future<void> _showchoiceDialog(BuildContext context, DonationModel model, index, FoodNotifier foodNotifier){
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Confirm Reservation (' + foodNotifier.foodList[index].itemname +')'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Material(
                    child: ScopedModelDescendant<DonationModel>(
                      builder: (context,child,model){
                        return _quantityContainer(model);
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),

                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: CupertinoDatePicker(
                          initialDateTime: _dateTime,
                          use24hFormat: true,
                          mode: CupertinoDatePickerMode.dateAndTime,
                          onDateTimeChanged: (dateTime){
                            print(dateTime);
                            setState(() {
                              _dateTime =dateTime;

                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Cancel',style: TextStyle(color: Colors.redAccent),),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Dessertstorage(),fullscreenDialog: true));
                        },
                      ),
                      RaisedButton(
                        child: Text('Confirm',style: TextStyle(color: Colors.redAccent),),
                        onPressed: (){
                          Firestore.instance.collection('Category').document('FoodCategory').collection('Dessert')
                              .document(_documentID[index]).updateData({'Reserved':true});
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
  Widget _quantityContainer(DonationModel model){

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Quantity '),
          RawMaterialButton(
            onPressed: (){
              model.decrement();
              quantities = model.count;
            },
            child: Icon(FontAwesomeIcons.minus,
              color: Colors.redAccent,
              size: 15.0,),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Color(0xffFAF4F2),
            padding: const EdgeInsets.all(10.0),
          ),
          Text(model.count.toString(), style: TextStyle(fontSize: 15),),
          RawMaterialButton(
            onPressed: (){
              model.increment();
              quantities = model.count;
            },
            child: Icon(FontAwesomeIcons.plus,
              color: Colors.redAccent,
              size: 15.0,),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Color(0xffFAF4F2),
            padding: const EdgeInsets.all(10.0),
          ),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Desserts'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),
/*
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Image.network(foodNotifier.foodList[index].imagePath),
            title: Text("Item: " + foodNotifier.foodList[index].itemname),
            subtitle: Text("Name: " + foodNotifier.foodList[index].address),
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

 */
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: (){
                _showchoiceDialog(context,donationModel, index, foodNotifier);

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
  void getDistance(lat2, lon2){
/*
    var dis = await Geolocator().distanceBetween(25.716250, -80.280849, endLatitude, endLongitude);
    var distance = dis *0.000621371;
    var value = double.parse(distance.toStringAsFixed(2));
    print(value);
*/
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - 25.716250) * p)/2 +
        c(25.716250 * p) * c(lat2 * p) *
            (1 - c((lon2 - -80.280849) * p))/2;
    var distance = 12742 * 0.621371* asin(sqrt(a));
    var value = double.parse(distance.toStringAsFixed(2));
    //await new Future.delayed(new Duration(seconds: 1));
    _distance.add(value);

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
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(child: Text("4.0",
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
                  Container(child: Text(" \u00B7 "+
                      _distance[index].toString()+
                      " mi",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                ],)),
        ),

      ],
    );
  }

  getDesserts(FoodNotifier foodNotifier) async{

    QuerySnapshot snapshot = await Firestore.instance.collection('Category').document('FoodCategory').collection('Dessert').getDocuments();

    List<Food> _foodList = [];
    snapshot.documents.forEach((document){
      if(document.data['Quantity'] > 0) {
        Food dessert = Food.fromMap(document.data);
        _foodList.add(dessert);
        getDistance(document['Coordinate'].latitude,
            document['Coordinate'].longitude);
        print(document.documentID);
        _documentID.add(document.documentID);
      }
    });


    foodNotifier.foodList = _foodList;
  }

}


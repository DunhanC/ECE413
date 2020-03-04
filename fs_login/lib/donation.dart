import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fs_login/Pages/home.dart';
import 'package:provider/provider.dart';
import 'package:fs_login/food_notifier.dart';
import 'package:fs_login/food.dart';


class Donation extends StatefulWidget {
  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  String foodType;
  Food _currentFruit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override

  void initState() {
    super.initState();
    FoodNotifier fruitNotifier = Provider.of<FoodNotifier>(context, listen: false);

    if (fruitNotifier.currentFruit != null) {
      _currentFruit = fruitNotifier.currentFruit;
    } else {
      _currentFruit = Food();
    }

  }


  Widget _itemname(){

      return    Container(
        padding: EdgeInsets.only(top: 5.0, left: 140.0,right: 140.0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Item Name is required';
            }

            if (value.length < 3 || value.length > 20) {
              return 'Name must be more than 3 and less than 20';
            }

            return null;
          },
          onSaved: (String value){
            _currentFruit.itemname = value;
            print(_currentFruit.itemname);
          } ,
          decoration: InputDecoration(
              labelText: 'Item Name',
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),
      );

  }


  Widget _pname(){

    return                 Container(
      padding: EdgeInsets.only(top: 5.0, left: 140.0,right: 140.0),
      child:
//                  SizedBox(height: 20.0,),
      TextFormField(
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }

          if (value.length < 3 || value.length > 20) {
            return 'Name must be more than 3 and less than 20';
          }

          return null;
        },
        onSaved: (value){
          _currentFruit.pname = value;
          print(_currentFruit.pname);
        } ,
        decoration: InputDecoration(
            labelText: 'Provider Name',
            labelStyle: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
        //obscureText: true,
      ),
    );

  }

  Widget _foodtype(){

    return                 Container(
      padding: EdgeInsets.only(top: 5.0, left: 140.0,right: 140.0),
      child:
//                  SizedBox(height: 20.0,),
      TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return 'Name is required';
          }

          if (value.length < 3 || value.length > 20) {
            return 'Name must be more than 3 and less than 20';
          }

          return null;
        },
        onSaved: (value) {
          foodType = value;
          print(foodType);
        },
        decoration: InputDecoration(
            labelText: 'Food Type',
            labelStyle: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            )
        ),
        //obscureText: true,
      ),
    ) ;


  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Donation"),
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),

      body: new Column(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: true,
            //padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
            child: Column(

              children: <Widget>[
                _itemname(),
                _pname(),
                _foodtype()

              ],
            ),
          ),

          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(top: 5.0, left: 140.0,right: 140.0),
            height: 45.0,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.redAccent,
              color: Colors.redAccent,
              elevation: 7.0,
              child: GestureDetector(
                onTap: (){
                  _formKey.currentState.save();
                  donateFood(_currentFruit,_currentFruit.itemname,foodType);
                },
                child: Center(
                  child: Text(
                    'Donate',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }



  donateFood(Food fruit, String itemName, String foodType) async{
    CollectionReference foodRef = await Firestore.instance.collection(foodType)
        .document('fruitstorage').collection(itemName);
    DocumentReference documentReference = await foodRef.add(fruit.toMap());
    print('uploaded food successfully: ${fruit.toString()}');

    await documentReference.setData(fruit.toMap(), merge: true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true));
  }
}

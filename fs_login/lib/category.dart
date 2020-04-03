import 'package:flutter/material.dart';
import 'package:fs_login/Pages/home.dart';
import 'package:fs_login/breadStorage.dart';
import 'package:fs_login/fruitStorage.dart';
import 'package:fs_login/proteinstorage.dart';
import 'package:fs_login/frozenStorage.dart';
import 'package:fs_login/vegetableStorage.dart';
import 'package:fs_login/drinkstorage.dart';
import 'package:fs_login/instantstorage.dart';
import 'package:fs_login/seafoodstorage.dart';
import 'package:fs_login/dessertstorage.dart';
import 'package:fs_login/cannedstorage.dart';


class FoodCategories extends StatefulWidget {
  @override
  _FoodCategoriesState createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Reservation"),
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true))
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          new ListTile(
            title: Text('Fruit'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Fruitstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Protein'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Proteinstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Bread'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Breadstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Vegetable'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Vegetablestorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Frozen'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Frozenstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Canned'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Cannedstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Drink'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Drinkstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Instant'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Instantstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Seafood'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Seafoodstorage(),fullscreenDialog: true));
              },
            ),
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Dessert'),
            trailing: RaisedButton(
              color: Colors.redAccent,
              child: Text('Choose'),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Dessertstorage(),fullscreenDialog: true));
              },
            ),
          ),

        ],
      ),
    );
  }
}

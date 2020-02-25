import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'AppBar Scaffold',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text('FoodSavior');

  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
        ),


        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if(this.customIcon.icon == Icons.search)
                {
                  this.customIcon = Icon(Icons.cancel);
                  this.customSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search for food",
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                }
                else
                {
                  this.customIcon = Icon(Icons.search);
                  this.customSearchBar = Text("FoodSavior");
                }
              });
            },
            icon: customIcon,
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],


        title: customSearchBar,
      ),
    );
  }
}


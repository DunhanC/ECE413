import 'package:flutter/material.dart';

class NFavor extends StatefulWidget {
  @override
  _NFavorState createState() => _NFavorState();
}

class _NFavorState extends State<NFavor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Favorite"),
        automaticallyImplyLeading: false,
      ),

      body: new Center(
        child: new Text("Favorite shown here"),
      ),
    );
  }
}

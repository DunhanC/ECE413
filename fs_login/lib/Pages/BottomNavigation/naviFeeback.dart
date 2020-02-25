import 'package:flutter/material.dart';

class NFeeback extends StatefulWidget {
  @override
  _NFeebackState createState() => _NFeebackState();
}

class _NFeebackState extends State<NFeeback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Feedback"),
        automaticallyImplyLeading: false,
      ),

      body: new Center(
        child: new Text("Feedback shown here"),
      ),
    );
  }
}

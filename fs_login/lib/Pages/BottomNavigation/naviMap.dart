import 'package:flutter/material.dart';

class NMap extends StatefulWidget {
  @override
  _NMapState createState() => _NMapState();
}

class _NMapState extends State<NMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Map"),
        automaticallyImplyLeading: false,
      ),

      body: new Center(
        child: new Text("Map shown here"),
      ),
    );
  }
}

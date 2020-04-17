import 'package:flutter/material.dart';
import 'package:fs_login/search_bar.dart';
import 'package:fs_login/donation.dart';

class ShowPlace extends StatefulWidget {
  @override
  _ShowPlaceState createState() => _ShowPlaceState();
}

class _ShowPlaceState extends State<ShowPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Search(),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Donation(),fullscreenDialog: true)),
        ),
      ),
    );
  }
}


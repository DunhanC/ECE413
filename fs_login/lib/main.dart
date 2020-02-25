import 'package:flutter/material.dart';
import 'package:fs_login/Pages/Setup/signIn.dart';
import 'package:fs_login/Pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Home(),
    );
  }
}



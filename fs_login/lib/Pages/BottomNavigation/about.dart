import 'package:flutter/material.dart';
import '../home.dart';
class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final double leading = 0.9;
  final double textLineHeight = 2;
  final double fontSize = 16;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text("About Us",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.31089, 1.09827),
            end: Alignment(0.68911, -0.09827),
            stops: [
              0.00917,
              0.15496,
              0.38715,
            ],
            colors: [
              Color.fromARGB(255, 255, 247, 247),
              Color.fromARGB(255, 204, 181, 210),
              Color.fromARGB(255, 190, 168, 201),
            ],
          ),
        ),
        child: Column(
            children: [
            Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 59,
              height: 56,
              margin: EdgeInsets.only(left: 45, top: 48),
              /*
              child: Image.asset(
                "assets/images/active-icon-8.png",
                fit: BoxFit.none,
              ),

               */
    ),
          ),
             Container(
               width: 338,
              height: 236,
              margin: EdgeInsets.only(top: 36),
              child: Text(
                textContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:Colors.white,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w400,
                  fontSize: 18,

                ),
              ) ,
      ),
        Spacer(),
         Container(margin: EdgeInsets.only(bottom: 20),
          child: Text(
          "© 2020 FoodSavior",
          textAlign: TextAlign.center,
          style: TextStyle(
          color:Colors.purpleAccent,
          fontFamily: "Lato",
          fontWeight: FontWeight.w400,
          fontSize: 15,
     ),
    )
         ),
        ],
      ),
      ),
    );
  }
}

const  textContent =
    "FoodSavior is an App that help\npeople to save the Food.\nYou can choose to donate extra food, "
    "\nor youcan choose to \nget food donated by others. \nWe all have a responsibility to help reduce food loss and waste, \nboth for the food itself and for not wasting the resources"
    " \nconsumed by the production of food.\nSign in and play with it!";

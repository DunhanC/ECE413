import 'package:flutter/material.dart';
import '../home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text("Profile",
          style: TextStyle(
           color: Colors.black
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(),fullscreenDialog: true)),
        ),
      ),
      body: ListView(
        //padding: EdgeInsets.all(0.0),
        children: <Widget>[
          Container(
            child: Padding(padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 90,
                    width: 90,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(100.0)
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/AccountPic.jpeg'), fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Dunhan Chen",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),),
          ),
          Container(
            child: Column(
              children: <Widget>[
                  Text("Email Address",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

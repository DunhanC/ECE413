import 'package:flutter/material.dart';
import '../home.dart';
class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
        title: Text("Q&A",
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
                width: 359,
                height: 56,
                margin: EdgeInsets.only(top: 22, bottom: 20),
                /*
                child: Image.asset(
                  "assets/images/active-icon-8.png",
                  fit: BoxFit.none,
                ),

                 */
              ),
            ),
            Container(
              width: 400,
              height: 360,
              margin: EdgeInsets.only(top: 22, bottom: 20),
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
const textContent=
    "Q: How can I donate/receive  food?\nA: You can easiliy do it by clicking the “+”\n     at the botton front page.\n\nQ: Do I need to pay booking fee?\nA：Not at all. FoodSavior is totally free.\n\nQ: Do I need to contact the donator \n     or receiver?\nA: You don't have to. We can manage all the \n     processes. However, you can contact \n     the object if you want to.\n\nQ: What if I have a problem with my food?\nA: All the users must sign a contract which\n     including food safety. We will help to \n     you track and deal with the problem\n";
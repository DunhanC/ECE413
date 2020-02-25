import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fs_login/Pages/Setup/signUp.dart';
import 'package:fs_login/Pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';



class MyLoginPage extends StatefulWidget {

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}


class _MyLoginPageState extends State<MyLoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null)
        return false;
      AuthResult res = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken,
          ));
      if (res.user == null)
        return false;
      return true;
    } catch (e) {
      print("Error logging with google");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                        child: Text(
                          'Food',
                          style: TextStyle(
                            fontFamily: 'Sriracha',
                            fontSize: 70.0,
                          ),
                        ),
                      ),
                      /*
                      Container(
                        padding: EdgeInsets.fromLTRB(90.0, 40.0, 0.0, 0.0),
                        child: Image.asset('assets/images/fs-logo.jpeg', width: 80,height: 60),
                      )*/
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(150.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Savior',
                      style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 70.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,

              //padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
              child: Column(

                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
                    child: TextFormField(
                    validator: (input) {
                      if(input.isEmpty){
                        return 'Please type an email';
                      }
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        )
                    ),
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
                    child:
//                  SizedBox(height: 20.0,),
                  TextFormField(
                    validator: (input) {
                      if(input.length < 6){
                        return 'Password length should be at least 6';
                      }
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                        )
                    ),
                    obscureText: true,
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
              child: InkWell(
                child: Text('Forgot Password?',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
              height: 45.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Colors.blue,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
              height: 45.0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () async{
                  bool res = await loginWithGoogle();
                  if(!res)
                    print("error logging in with google");
                  else
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(), fullscreenDialog: true));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image.asset('assets/images/google.png',width: 23.0,height: 23.0),
                      ),
                      SizedBox(width: 10.0),
                      Center(
                        child: Text('Login with google',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20.0,right: 20.0),
              height: 45.0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: (){
                 // _loginWithFB();

                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image.asset('assets/images/facebook.png',width: 30.0,height: 30.0),
                      ),
                      SizedBox(width: 10.0),
                      Center(
                        child: Text('Login with facebook',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to FoodSavior?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monsterrat'
                  ),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: (){
                    signUp();

                  },
                  child: Text('Sign Up',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monsterrat',
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
              ],
            )
          ],
        )
    );
  }
  Future <void> signIn() async {
    final _formState = _formKey.currentState;
    if(_formState.validate()){
      _formState.save();
      try {
        AuthResult user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(), fullscreenDialog: true));
      }catch(e){
        print(e.message);
      }
    }
  }

  void signUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage(),fullscreenDialog: true));
  }

}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fs_login/Pages/Setup/signIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Sign Up Page'),
      ),
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 120.0,right: 120.0),
              height: 45.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Colors.blue,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: (){
                    signUp();
                  },
                  child: Center(
                    child: Text(
                      'Sign Up',
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
          ],
        )
    );
  }
  Future <void> signUp() async {
    final _formState = _formKey.currentState;
    if(_formState.validate()){
      _formState.save();
      try {
        AuthResult user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password));
        user.user.sendEmailVerification();
        //Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyLoginPage(),fullscreenDialog: true));
      }catch(e){
        print(e.message);
      }
    }
  }
}

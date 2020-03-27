//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fs_login/Pages/Setup/signIn.dart';
import 'package:fs_login/user.dart';
import 'package:fs_login/fs_api.dart';
import 'package:fs_login/auth_notifier.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordControl = new TextEditingController();
  User _user = User();

  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(
        context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(
        context, listen: false);

    signup(_user, authNotifier);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MyLoginPage(), fullscreenDialog: true));
  }


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
                    padding: EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return "Please type an email";
                        }
                        if (!RegExp(
                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(input)) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                      onSaved: (input) => _user.email = input,
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
                    padding: EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child:
//                  SizedBox(height: 20.0,),
                    TextFormField(
                      controller: _passwordControl,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Password is required';
                        }

                        if (input.length < 5 || input.length > 20) {
                          return 'Password must be betweem 5 and 20 characters';
                        }

                        return null;
                      },
                      onSaved: (input) => _user.password = input,
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
              padding: EdgeInsets.only(top: 10.0, left: 120.0, right: 120.0),
              height: 45.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.blueAccent,
                color: Colors.blue,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    _submitForm();
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
}
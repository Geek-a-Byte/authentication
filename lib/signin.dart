import 'dart:convert';
import 'package:chatar_matha/homescreen.dart';
import 'package:chatar_matha/screens/overview_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'dart:async';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String verificationId;

  Future<void> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    print(phone);
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 120),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        AuthResult result = await _auth.signInWithCredential(credential);

        FirebaseUser user = result.user;

        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              //builder: (context) => OverviewScreen(user),
              builder: (context) => HomeScreen(
                user: user,
                //name: userName,
              ),
            ),
          );
        } else {
          print("Error");
        }
        //this verification is done when
      },
      verificationFailed: (AuthException e) {
        print(e.message);
      },
      codeSent: (String verId, [int forceResendingToken]) {
        verificationId = verId;
        print('Verification id is:');
        print(verificationId);

        showDialog(

            //barrierDismissible: false,
            context: context,
            builder: (dialogContex) {
              return AlertDialog(
                  title: Text("Give me code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _codeController,
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                          verificationId: verificationId,
                          smsCode: code,
                        );
                        try {
                          AuthResult result =
                              await _auth.signInWithCredential(credential);

                          FirebaseUser user = result.user;
                          //the next line is for to close the give my code dialog box after signing in successfully
                          Navigator.of(context, rootNavigator: true).pop();
                          SuccessAlertBox(
                              context: context,
                              //icon: Icons.done,
                              title: "Login Successful!",
                              messageText: "The contact no was verified.");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //builder: (context) => OverviewScreen(user),
                              builder: (context) => HomeScreen(
                                user: user,
                                //name: userName,
                              ),
                            ),
                          );
                        } catch (Exp) {
                          print(Exp);
                          WarningAlertBox(
                              context: context,
                              title: "Sorry ! Try Again.",
                              messageText: "Invalid NID or contact no or OTP");
                        }
                      },
                    )
                  ]);
            });
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }
  // String title = "Sign in";
  //int NID = 2019140;

  var name = 'User';
  String pass = 'robocup';

  gotoHomeScreen(var userName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Color(0xfff5f5f5),
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0, //Width equal to device
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.35,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: TextFormField(
                                controller: _nameController,

                                decoration: InputDecoration(
                                  labelText: "Name : ",

                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontFamily: 'HelveticaNeue',
                                    fontWeight: FontWeight.bold,
                                  ),

                                  hintText: "Your Name",
                                  // contentPadding: EdgeInsets.only(
                                  //   bottom: MediaQuery.of(context).size.height *
                                  //       .05,
                                  // ),
                                  hintStyle: TextStyle(color: Colors.black54),

                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38),
                                  ),

                                  // and:

                                  focusedBorder: new UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12),
                                  ),
                                ),
                                cursorColor: Colors.black54,
                                //cursorWidth: 7.000000,
                                //cursorRadius: Radius.elliptical(10, 15),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _phoneController,
                                    // obscureText:
                                    //     (_showPass == true) ? false : true,
                                    decoration: InputDecoration(
                                      labelText: "Phone No : ",

                                      hintText: "+880*********",

                                      // contentPadding: EdgeInsets.only(
                                      //   bottom:
                                      //       MediaQuery.of(context).size.height *
                                      //           .05,
                                      // ),

                                      // suffixIcon: IconButton(
                                      //   onPressed: _toggle,
                                      //   icon: !_showPass
                                      //       ? Icon(Icons.visibility_off)
                                      //       : Icon(Icons.visibility),
                                      // ),

                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold,
                                      ),

                                      border: new UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black38),
                                      ),

                                      // and:

                                      focusedBorder: new UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                    cursorColor: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    // obscureText:
                                    //     (_showPass == true) ? false : true,
                                    decoration: InputDecoration(
                                      labelText: "Email : ",

                                      hintText: "your email id:",

                                      // contentPadding: EdgeInsets.only(
                                      //   bottom:
                                      //       MediaQuery.of(context).size.height *
                                      //           .05,
                                      // ),

                                      // suffixIcon: IconButton(
                                      //   onPressed: _toggle,
                                      //   icon: !_showPass
                                      //       ? Icon(Icons.visibility_off)
                                      //       : Icon(Icons.visibility),
                                      // ),

                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold,
                                      ),

                                      border: new UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black38),
                                      ),

                                      // and:

                                      focusedBorder: new UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                    cursorColor: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _passwordController,
                                    // obscureText:
                                    //     (_showPass == true) ? false : true,
                                    decoration: InputDecoration(
                                      labelText: "Password : ",

                                      hintText: "*********",

                                      // contentPadding: EdgeInsets.only(
                                      //   bottom:
                                      //       MediaQuery.of(context).size.height *
                                      //           .05,
                                      // ),

                                      // suffixIcon: IconButton(
                                      //   onPressed: _toggle,
                                      //   icon: !_showPass
                                      //       ? Icon(Icons.visibility_off)
                                      //       : Icon(Icons.visibility),
                                      // ),

                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold,
                                      ),

                                      border: new UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black38),
                                      ),

                                      // and:

                                      focusedBorder: new UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                    cursorColor: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: ButtonTheme(
                                    minWidth: 150,
                                    height: 40,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Color(0xff0984e3),
                                      child: Row(
                                        children: <Widget>[
                                          //Icon(Icons.person_add, color: Colors.white),  I PERSONALLY DON'T PREFER THIS THO
                                          Text(
                                            "Sign in",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontFamily: 'HelveticaNeue',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      //color: Colors.black,    I CHANGED THIS//RAIYAN
                                      //onPressed: () => gotoHomeScreen(name),
                                      onPressed: () {
                                        final phone =
                                            _phoneController.text.trim();

                                        loginUser(phone, context);
                                      },
                                    ),
                                  ),
                                ), //raised button
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.width * .075,
                              ),
                              child: new RichText(
                                text: new TextSpan(
                                  children: [
                                    new TextSpan(
                                      text: "Don't have an account? ",
                                      style:
                                          new TextStyle(color: Colors.black54),
                                    ),
                                    new TextSpan(
                                      text: 'Create one!',
                                      style: new TextStyle(color: Colors.blue),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, '/SignUp');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//? this is a question
//* this is an important part of code or important comment
//TODO: this is for future plans of refactoring or updating the codes with new features
//! this is the error/mistake/bad execution of code which should be avoided for the next time

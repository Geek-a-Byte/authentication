//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:chatar_matha/PageOne.dart';
import 'package:chatar_matha/screens/product_details_screen.dart';
import 'package:chatar_matha/splashscreen.dart';
import 'package:chatar_matha/widgets/product_item.dart';
import 'package:chatar_matha/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:chatar_matha/SignUp.dart';
import 'package:chatar_matha/signin.dart';
import 'PageTwo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/PageOne': (context) => PageOne(),
          '/PageTwo': (context) => PageTwo(),
          '/SignUp': (context) => SignUp(),
          //'/dashboard': (context) => DashBoard(),
          '/signin': (context) => SignIn(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        });
  }
}

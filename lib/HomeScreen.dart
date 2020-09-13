import 'package:chatar_matha/product_details_screen.dart';
import 'package:chatar_matha/products_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'overview_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;
  String name;
  HomeScreen({this.user, this.name});
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     padding: EdgeInsets.all(32),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Text(
    //           "You are Logged in succesfully",
    //           style: TextStyle(color: Colors.lightBlue, fontSize: 32),
    //         ),
    //         SizedBox(
    //           height: 16,
    //         ),
    //         Text(
    //           "${user.phoneNumber}",
    //           style: TextStyle(
    //             color: Colors.grey,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Food Donation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
          fontFamily: 'HelveticaNeue',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: OverviewScreen(user, name),
        routes: {
          /// must define it in main.dart..it reduced state management complexity!
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}

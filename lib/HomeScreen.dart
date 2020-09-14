// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './screens/overview_screen.dart';
// import './screens/product_details_screen.dart';
// import 'package:chatar_matha/providers/products_provider.dart';

// void main() => runApp(HomeScreen());

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// // class HomeScreen extends StatelessWidget {
// //   //This is where username goes in
// //   final FirebaseUser user;
// //   String name;
// //   HomeScreen({this.user, this.name});

// //   @override
// //   //HomeScreen(userName);
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (ctx) => Products(),
// //       child: MaterialApp(
// //         title: 'Food Donation',
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //           accentColor: Colors.blue,
// //           fontFamily: 'HelveticaNeue',
// //           visualDensity: VisualDensity.adaptivePlatformDensity,
// //         ),
// //         home: OverviewScreen(user, name),
// //         routes: {
// //           /// must define it in main.dart..it reduced state management complexity!
// //           ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
// //         },
// //       ),
// //     );
// //   }
// // }

// class _HomeScreenState extends State<HomeScreen> {
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Phone Auth Demo"),
//         backgroundColor: Colors.cyan,
//       ),
//       body: FutureBuilder(
//         future: FirebaseAuth.instance.currentUser(),
//         builder: (context, snapshot) {
//           FirebaseUser firebaseUser = snapshot.data;
//           return snapshot.hasData
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "SignIn Success 😊",
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text("UserId: ${firebaseUser.uid}"),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                           "Registered Phone Number: ${firebaseUser.phoneNumber}"),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       RaisedButton(
//                         onPressed: _logout,
//                         child: Text(
//                           "LogOut",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: Colors.cyan,
//                       )
//                     ],
//                   ),
//                 )
//               : CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/overview_screen.dart';
import './screens/product_details_screen.dart';
import 'package:chatar_matha/providers/products_provider.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  //This is where username goes in
  final FirebaseUser user;
  String name;
  HomeScreen({this.user, this.name});

  @override
  //HomeScreen(userName);
  Widget build(BuildContext context) {
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

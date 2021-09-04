import 'package:bedridden/routere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'Screen/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

String initialRoute = '/Homepage';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/myService';
      }
      runApp(myapp());
    });
  });
}

class myapp extends StatefulWidget {
  const myapp({ Key? key }) : super(key: key);

  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    routes: routes,
    initialRoute: initialRoute,
    debugShowCheckedModeBanner: false,
    home: Homepage(),
    ) ;
  }
}
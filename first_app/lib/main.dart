// ignore_for_file: prefer_const_constructors
//packages
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

//Screens
import 'screens/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(), 
      // MyHomePage(title: '',),
      
      debugShowCheckedModeBanner: false,
    );
  }
}


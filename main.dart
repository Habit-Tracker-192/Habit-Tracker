import 'package:flutter/material.dart';
import 'package:app2/Screens/Addgoal/addgoal.dart';
import 'package:app2/colors.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
      
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Color.fromARGB(255, 150, 129, 184),

      ),
      home: AddGoal(),
    );
  }
}
 
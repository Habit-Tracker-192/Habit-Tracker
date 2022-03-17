// import 'dart:html';
// import 'package:flutter/services.dart';
import 'package:first_app/notifs.dart';
import 'package:first_app/home.dart';
import 'package:first_app/goals_medyofinal.dart';
import 'package:first_app/profile.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
void main() {
  runApp(MyApp());
}

Map<int, Color> purple =
{
50:const Color.fromRGBO(100, 88, 204, .1),
100:const Color.fromRGBO(100, 88, 204, .2),
200:const Color.fromRGBO(100, 88, 204, .3),
300:const Color.fromRGBO(100, 88, 204, .4),
400:const Color.fromRGBO(100, 88, 204, .5),
500:const Color.fromRGBO(100, 88, 204, .6),
600:const Color.fromRGBO(100, 88, 204, .7),
700:const Color.fromRGBO(100, 88, 204, .8),
800:const Color.fromRGBO(100, 88, 204, .9),
900:const Color.fromRGBO(100, 88, 204, 1),
};


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    Goal(),
    Notif(),
    Profile(),
  ];
  
  final frequencies = [
      'Daily',
      'Weekly',
      'Monthly'
    ];

  TextEditingController _timesController = TextEditingController(text:1.toString());
  TextEditingController _durationController = TextEditingController(text:1.toString());
  TextEditingController _goalNameController = TextEditingController();
  TextEditingController _goalDescriptionController = TextEditingController();

  String frequency = 'Daily';

  var _textformfield_times = GlobalKey<FormFieldState>();
  var _textformfield_duration = GlobalKey<FormFieldState>();
  var _textformfield_frequency = GlobalKey<FormFieldState>();
  var _textformfield_goalName = GlobalKey<FormFieldState>();
  var _textformfield_goalDescription = GlobalKey<FormFieldState>();

  String? value;
  @override
  Widget build(BuildContext context) {
    
    DropdownMenuItem<String> buildMenuItem(String some) => DropdownMenuItem(
        value: some,
        child: Text(
          some, 
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18,
          ),
        ),
      );

    MaterialColor themeColor= MaterialColor(0xFF5462CF, purple);
    return MaterialApp(
    theme: ThemeData(
      primarySwatch: themeColor,
      scaffoldBackgroundColor:const Color.fromRGBO(176,156,220, 1),
      shadowColor: Colors.grey,
      // bottomAppBarColor: themeColor,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row( 
          children: <Widget>[
            Image.asset('assets/images/habit_tracker_logo.png', fit: BoxFit.cover, width: 60, height:60, ),
            const Text('Habit Tracker'),
          ],
          ),
        ),
        body: screens[currentIndex]

        bottomNavigationBar: SizedBox(
          height: 75,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color.fromRGBO(100, 88, 204, 1),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded,size: 45),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined, size: 45),
                label: 'Goals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.email_outlined, size: 45),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded, size: 45),
                label: 'Profile',
              ),
            ],
            elevation: 0, 
          ),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            tooltip: 'Add',
            child: const Icon(Icons.add),
            backgroundColor: themeColor[900],
          ),
        ),     
      );
  }
}

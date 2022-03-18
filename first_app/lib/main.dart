// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/goals.dart';
import 'screens/notifs.dart';
import 'screens/addgoal.dart';
import 'screens/profile.dart';
import 'screens/home.dart';


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
      home: MyHomePage(title: '',),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

   final screens = [
    HomePage(),
    Goal(),
    Notif(),
    Profile(),
    AddGoal(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text(widget.title),
      //),
      body: screens[_currentIndex],
      bottomNavigationBar: SizedBox(
          height: 85,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color.fromRGBO(100, 88, 204, 1),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
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
            // onTap: (index) {
            //   setState(() {
            //     _currentIndex = index;
            //   });
            // },
            elevation: 0, 
          ),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => const AddGoal()),
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddGoal()),

            );
                //onTabTapped(3);
            }, 
            tooltip: 'Add',
            child: const Icon(Icons.add),
            backgroundColor: Color.fromRGBO(100, 88, 204, 1),
          ),
      
    );
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

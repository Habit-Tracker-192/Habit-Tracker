// import 'dart:html';
// import 'package:flutter/services.dart';
import 'package:first_app/notifications.dart';
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
    NotificationPage(),
    ProfilePage(),
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
        body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                TextFormField(
                  key: _textformfield_goalName,
                  controller: _goalNameController,
                  decoration: const InputDecoration(
                    hintText: 'Your Goal Name',
                    labelText: 'Goal Name',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color:  Color.fromRGBO(100, 88, 204, 1),
                    ),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(255 ,221,223,245),
                    filled: true,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if (value!.isNotEmpty && value.length <= 24 ){
                      return null;
                    }
                    else if (value.isEmpty){
                      return 'Please add a goal name';
                    } 
                    else {
                      return 'Goal Name is too long!';
                    }
                  },
                ),

                TextFormField(   
                  decoration: const InputDecoration(
                    hintText: 'Which one of your Categories does this Goal belong?',
                    labelText: 'Category',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color:  Color.fromRGBO(100, 88, 204, 1),
                    ),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(255 ,221,223,245),
                    filled: true,
                  ),
                ),

                DropdownButtonFormField<String>(
                  value: value,
                  key: _textformfield_frequency,
                  dropdownColor: Color.fromARGB(255 ,221,223,245),
                  isExpanded: true,
                  items: frequencies.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => frequency = value!),
                  iconEnabledColor:  const Color.fromRGBO(100, 88, 204, 1),
                  style: const TextStyle(
                    color:  Color.fromRGBO(100, 88, 204, 1),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'How often would you like to achieve your goal?',
                    labelText: 'Frequency',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color:  Color.fromRGBO(100, 88, 204, 1),
                    ),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(255 ,221,223,245),
                    filled: true,
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return 'you must choose a frequency';
                    }
                    else{
                      return null;
                    }
                  },
                ),

                TextFormField(
                  // onChanged: (value) =>setState(() => this.);,\
                  key: _textformfield_times,
                  controller: _timesController,
                  decoration: const InputDecoration(
                    hintText: 'Adjust if you want more than once a day/week/month',
                    labelText: 'Times',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color:  Color.fromRGBO(100, 88, 204, 1),
                    ),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(255 ,221,223,245),
                    filled: true,
                    // errorText: _timesError,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (val){
                    if (val!.isEmpty){
                      return 'Please put your desired number of repetition/s';
                    }

                    else if (frequency == 'Daily' && double.tryParse(val!)!<= 24 ){
                      return null;
                    }
                    
                    else if (frequency == 'Weekly' && double.tryParse(val!)!<= 6 ){
                      return null;
                    }

                    else if (frequency == 'Monthly' && double.tryParse(val!)!<= 30 ){
                      return null;
                    }

                    else {
                      return 'You have exceeded the maximum amount of repetitions';
                    } 
                  },
                ),

                TextFormField(
                  key: _textformfield_duration,
                  controller: _durationController,
                  decoration: const InputDecoration(
                    hintText: 'How many hours would it take?',
                    labelText: 'Duration',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color:  Color.fromRGBO(100, 88, 204, 1),
                    ),
                    border: OutlineInputBorder(),
                    fillColor: Color.fromARGB(255 ,221,223,245),
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please enter duration';
                    }
                    else if (frequency == 'Daily' && (int.tryParse(value!)!*int.tryParse(_timesController.text)!)  > 24){
                      return 'Duration exceeded number of hours per day!';
                    }
                    else if (frequency == 'Weekly' && (int.tryParse(value!)!*int.tryParse(_timesController.text)!) > 168){
                      return 'Duration exceeded number of hours per week!';
                    }
                    else if (frequency == 'Monthly' && (int.tryParse(value)!* int.tryParse(_timesController.text)!) > 744){
                      return 'Duration exceeded number of hours per month!';
                    }
                  },
                ),

                TextFormField(
                  key: _textformfield_goalDescription,
                  controller: _goalDescriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Detailed description of your goal.',
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color:  Color.fromRGBO(100, 88, 204, 1),
                    ),
                    enabledBorder: OutlineInputBorder(),
                    fillColor: Color.fromARGB(255 ,221,223,245),
                    filled: true,
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Please add a goal description';
                    }
                    else if (value!.isNotEmpty && value.length <= 99 ){
                      return null;
                    } 
                    else {
                      return 'Goal description is too long!';
                    }
                  },
                ),
                
                RaisedButton(
                  onPressed: (){
                    if (!_textformfield_goalName.currentState!.validate()){}
                    if (!_textformfield_frequency.currentState!.validate()){}
                    if (!_textformfield_times.currentState!.validate()){}
                    if (!_textformfield_duration.currentState!.validate()){}
                    if (!_textformfield_goalDescription.currentState!.validate()){}
                  },    
                  child: const Text('Add'),
                  textColor: Colors.white,
                  color: const Color.fromRGBO(100, 88, 204, 1),
                ),
              ],
            ),

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

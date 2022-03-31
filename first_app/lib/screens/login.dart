//package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'dart:io';

//screeens
import 'goals.dart';
import 'notifs.dart';
import 'addgoal.dart';
import 'profile.dart';
import 'home.dart';
import 'signup.dart';
import 'package:first_app/components/already_have_an_account_acheck.dart';

  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();
  var _textformfield_login_email = GlobalKey<FormFieldState>();
  var _textformfield_login_password = GlobalKey<FormFieldState>();

class Login extends StatelessWidget {

  Login({ Key? key }) : super(key: key);
  final _formKey1 = GlobalKey<FormState>();
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(88, 100, 204, 1),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) 
        {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child:SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/habit_tracker_logo.png'),
                        TextFormField(
                                    key: _textformfield_login_email,
                                    controller: _emailLoginController,
                                    decoration:  InputDecoration(
                                      hintText: 'Email',
                                      labelStyle: const TextStyle(
                                        fontSize: 18,
                                        color:  Color.fromRGBO(100, 88, 204, 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(100, 88, 204, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      fillColor: const Color.fromARGB(255 ,221,223,245),
                                      filled: true,
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Please enter username';
                                      }
                                      
                                    },
                                  ),
                        SizedBox(height: 10),
                        TextFormField(
                                    key: _textformfield_login_password,
                                    controller: _passwordLoginController,
                                    decoration:  InputDecoration(
                                      hintText: 'Password',
                                      labelStyle: const TextStyle(
                                        fontSize: 18,
                                        color:  Color.fromRGBO(100, 88, 204, 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(100, 88, 204, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      fillColor: const Color.fromARGB(255 ,221,223,245),
                                      filled: true,
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Please enter password';
                                      }
                                      
                                    },
                                    obscureText: true,
                                  ),
                        SizedBox(height: 30),
                        MaterialButton(
                                    minWidth: 120,
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)
                                      ),
                                    child: const Text(
                                      'Sign In',
                                      style: 
                                        TextStyle(
                                          fontWeight: FontWeight.bold, 
                                          fontSize: 18,
                                        ),
                                      
                                      ),
                                    textColor: Colors.white,
                                    color: const Color.fromRGBO(48,52,68, 1),
                                    onPressed: () async {
                                          String _connectionerror = '';
                                          try {//tries to connect to google.com to check if the user has access to internet
                                              final result = await InternetAddress.lookup('google.com');
                                              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                                if (_formKey1.currentState!.validate()) {//returns true if both fields are valid
                                                  User? user = await FireAuth.signInUsingEmailPassword(
                                                    email: _emailLoginController.text,
                                                    password: _passwordLoginController.text,
                                                    context: context,
                                                  );
                                                  if (user != null) {
                                                    Navigator.of(context)
                                                      .pushReplacement(
                                                        MaterialPageRoute(builder: (context) => const MyHomePage(title: '',)),
                                                      )
                                                      .then((_) => _formKey1.currentState?.reset());
                                                  }
                                                }
                                              }
                                            } on SocketException catch (_) {
                                              _connectionerror = 'Connection Error: Please connect your device to the internet';
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_connectionerror), backgroundColor: Colors.red,));
                                            }
                                        },
                                      // if ((_textformfield_username.currentState!.validate()) &&
                                      // (_textformfield_password.currentState!.validate())){
                                      //   return;
                                      // }  
                                    
                                  ),
                        SizedBox(height: 40),
                        AlreadyHaveAnAccountCheck(
                              press: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return SignUp();
                                    })
                                  );
                              },
                              screenFormKey: _formKey1,
                            )
                          ]
                    )
                  )
                )
              )
            );
          }
          return const Center(
            child: Text('Error: Your connection has timed out'),
          );
        }
      )
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
            showUnselectedLabels: false,
            showSelectedLabels:false,
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
  void onChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


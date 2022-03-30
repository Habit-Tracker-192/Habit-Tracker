//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/already_have_an_account_acheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//screens
import 'login.dart';
import 'package:first_app/main.dart';
import 'package:first_app/services/authenticate.dart';

//controllers
TextEditingController _usernameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _ageController = TextEditingController();
// no controller for gender bc it is a dropdown button
TextEditingController _passwordController = TextEditingController();

//global keys
var _textformfield_username = GlobalKey<FormFieldState>();
var _textformfield_email = GlobalKey<FormFieldState>();
var _textformfield_age = GlobalKey<FormFieldState>();
var _textformfield_gender = GlobalKey<FormFieldState>();
var _textformfield_password = GlobalKey<FormFieldState>();


//processing of account registration
bool _isProcessing = false;


class SignUp extends StatefulWidget {
  const SignUp({ Key? key}) : super(key: key);
  
  @override
  State<SignUp> createState() => _SignUpState();

  void _submitFn(String username, String email, int age, String gender, String password, bool isLogin, BuildContext ctx) {}
}

class _SignUpState extends State<SignUp> {
  final _formKey2 = GlobalKey<FormState>();

  //initialize function values
  bool _isLogin = true;
  String _userName = '';
  String _userEmail = '';
  late int _userAge;
  String _userGender = '';
  String _userPassword = '';
  String _initialGender = 'Prefer not to say';
  
  final FirebaseAuth _auth = FirebaseAuth.instance;//instance of user database
  
  Widget _buildPopupDialogSignup(BuildContext context) {
  return AlertDialog(
    title: const Text('Congrats! Your account has been created'),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Please login using your credentials back at the Login Page"),
      ],
    ),
    actions: <Widget>[
       FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
  }
  

  Future<void> _trySubmit( BuildContext context) async {//validates and creates user
    final isValid = _formKey2.currentState!.validate();
    FocusScope.of(context).unfocus();//remove keyboard after submitting

    if(isValid){
      _formKey2.currentState?.save();//save value of form if form is valid
      print([_userName, _userEmail, _userAge,_userGender, _userPassword,_isLogin,context]);
      User? user = await FireAuth.registerUsingEmailPassword(
        name: _userName,
        email: _userEmail,
        age: _userAge,
        gender: _userGender,
        password: _userPassword,
        context: context
      );
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialogSignup(context),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    var genders = [
      'Male',
      'Female',
      'Other',
      'Prefer not to say',
    ];
    String? value;
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

    return Scaffold(
      backgroundColor: const Color.fromRGBO(88, 100, 204, 1),
      body: Center(
        child:SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/habit_tracker_logo.png'),
                  TextFormField(
                              key: _textformfield_username,
                              controller: _usernameController,
                              decoration:  InputDecoration(
                                hintText: 'Username',
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
                                    color:  Color.fromARGB(255 ,221,223,245),
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
                                // else if (){}
                                
                              },

                              onSaved: (value) { //save value if the field is validated
                                _userName = value!;
                              },

                            ),
                  const SizedBox(height: 10),
                  TextFormField(
                              key: _textformfield_email,
                              controller: _emailController,
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
                                    color:  Color.fromARGB(255 ,221,223,245),
                                    width: 2.0,
                                  ),
                                ),
                                fillColor: const Color.fromARGB(255 ,221,223,245),
                                filled: true,
                              ),
                              validator: (value){
                                if (value!.isEmpty){
                                  return 'Please enter email';
                                }
                              },
                              onSaved: (value) { //save value if the field is validated
                                _userEmail = value!;
                              },
                            ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                                    key: _textformfield_age,
                                    controller: _ageController,
                                    keyboardType: TextInputType.number,
                                    decoration:  InputDecoration(
                                      hintText: 'Age',
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
                                          color:  Color.fromARGB(255 ,221,223,245),
                                          width: 2.0,
                                        ),
                                      ),
                                      fillColor: const Color.fromARGB(255 ,221,223,245),
                                      filled: true,
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Please enter age';
                                      }
                                      return null;
                                    },

                                    onSaved: (value) { //save value if the field is validated
                                      _userAge = int.tryParse(value!)!;
                                    },
                                  ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: DropdownButtonFormField<String>(
                                    value: _initialGender,
                                    key: _textformfield_gender,
                                    dropdownColor: const Color.fromARGB(255 ,221,223,245),
                                    isExpanded: true,
                                    items: genders.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() => _initialGender = value!),
                                    iconEnabledColor:  const Color.fromRGBO(100, 88, 204, 1),
                                    style: const TextStyle(
                                      color:  Color.fromRGBO(100, 88, 204, 1),
                                    ),
                                    decoration:  InputDecoration(
                                      hintText: 'Gender',
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
                                          color:  Color.fromARGB(255 ,221,223,245),
                                          width: 2.0,
                                        ),
                                      ),
                                      fillColor: const Color.fromARGB(255 ,221,223,245),
                                      filled: true,
                                    ),
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'You must choose a gender';
                                      }
                                      return null;
                                    },

                                    onSaved: (value) { //save value if the field is validated
                                      _userGender = value!;
                                    },
                                  ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                              key: _textformfield_password,
                              controller: _passwordController,
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
                                    color: Color.fromARGB(255 ,221,223,245),
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
                                return null;
                                
                              },
                              obscureText: true,
                              onSaved: (value) { //save value if the field is validated
                                _userPassword = value!;
                              },
                            ),
                  const SizedBox(height: 30),
                  MaterialButton(
                              minWidth: 120,
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                                ),
                              child: const Text(
                                'Sign Up',
                                style: 
                                  TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 18,
                                  ),
                                
                                ),
                              textColor: Colors.white,
                              color: const Color.fromRGBO(48,52,68, 1),
                              onPressed:  () async {
                                setState(() {
                                  _isProcessing = true;//currently processing the registration of acct
                                });
                                _trySubmit(context); 
                                setState(() {
                                  _isProcessing = false;//done processing
                                });
                              }
                              
                            ),
                  const SizedBox(height: 10),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {Navigator.push(context, MaterialPageRoute(builder: (context) {return Login();}));})
                ] 
              )
            )
          )
        )
      )
    );
  }
}

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
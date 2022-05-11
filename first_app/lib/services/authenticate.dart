import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireAuth {

  FirebaseAuth auth = FirebaseAuth.instance; //initializes instance of user database
  
  User? get currentUser => auth.currentUser;
  
  
  //register user
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required int age,
    required String gender,
    required String password,
    required BuildContext context,

  }) async {
    FirebaseAuth auth = FirebaseAuth.instance; //initializes instance of user database
    FirebaseFirestore _firestore = FirebaseFirestore.instance; //added
    User? user;
    String message = '';

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
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await _firestore.collection('UserData').doc(userCredential.user?.uid).set(  //added
      {"username":name, 
      "email": email,
      "age": age,
      "gender": gender,
      });     
      
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      // print('User created');
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialogSignup(context),
      );
      // user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {//register errors
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red,));
    } catch (e) {
      print(e);
    }
    return user;
  }

  //log in user
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    String message = '';
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red,));
    }
  return user;
  }
  
  //signout
  static Future signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      return await auth.signOut();
      
    } catch(e){
      print(e.toString());  
    }
   
  }
  //refresh user
  static Future<User?> refreshUser(User user) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  await user.reload();
  User? refreshedUser = auth.currentUser;

  return refreshedUser;
}
}

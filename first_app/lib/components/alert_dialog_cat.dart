// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel}

class AlertDialogsCat {

  //DocumentReference reference = FirebaseFirestore.instance.reference();
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String category,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(body + '\'' + category + '\'?'),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async { 
                  //String? data = _goal.goal;
                  final uid = FireAuth().currentUser?.uid;
                  (category != "Instance of 'CategoryEntity") ?
                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(category).delete().whenComplete(() {
                        print("$category deleted"); 
                        }): print("category delete");
                  Navigator.of(context).pop(DialogsAction.yes);},
              child: Text(
                'Confirm', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () => 
                  Navigator.of(context).pop(DialogsAction.cancel) ,
              child: Text(
                'Cancel', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      }
    );
    return (action != null) ? action : DialogsAction.cancel;
  }
}

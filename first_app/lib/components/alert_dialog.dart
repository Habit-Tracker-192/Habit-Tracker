// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel}

class AlertDialogs {

  //DocumentReference reference = FirebaseFirestore.instance.reference();
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String goal,
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
          content: Text(body + '\'' + goal + '\'?'),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async { 
                  //String? data = _goal.goal;
                  final uid = FireAuth().currentUser?.uid;
                  (goal != "Instance of 'CategoryEntity") ?
                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('goals').doc(goal).delete().whenComplete(() {
                        print("$goal deleted"); 
                        FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(category).update({'hasGoal': false});
                        Navigator.of(context).pop(DialogsAction.yes);
                        showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialogDeleteGoal(context));
                        }): print("");
                  // await FirebaseFirestore.instance.collection('UserData').doc(uid).collection(goal.goalcategory).doc().collection('goals').doc(goal).delete().whenComplete(() {
                  //       print("$goal deleted"); 
                  //       }): print("");
                  //Navigator.of(context).pop(DialogsAction.yes);
                  },
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
  static _buildPopupDialogDeleteGoal(BuildContext context) {
    return AlertDialog(
    title: const Text('Successfully deleted a goal!'),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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
}

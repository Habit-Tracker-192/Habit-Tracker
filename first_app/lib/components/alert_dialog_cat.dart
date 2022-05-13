// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/goalList.dart';
import 'package:first_app/services/authenticate.dart';
//import 'package:first_app/components/alert_dialog_deleteGoal.dart';
import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel}

class AlertDialogsCat {

  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String category,
    String hasGoal,
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
                  
                  final uid = FireAuth().currentUser?.uid;   
                  final snapshot = await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(category).collection('goals').limit(1).get();

                  // (hasGoal != 'true') ?
                  // await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(category).delete().whenComplete(() {
                  //       //print("$category deleted "); 
                  //       Navigator.of(context).pop(DialogsAction.yes);
                  //       showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) => _buildPopupDialogDeleteCategory(context) ,
                  //         ); 
                  //       }): 
                  //       Navigator.of(context).pop(DialogsAction.yes);
                  //       showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) => _buildPopupDialogCannotDeleteCategory(context)
                  //        ,
                  //         ); 
                  if(hasGoal != 'true'){
                    await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(category).delete().whenComplete(() {
                        print("$category deleted "); 
                        Navigator.of(context).pop(DialogsAction.yes);
                        showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialogDeleteCategory(context) ,
                          ); 
                        });
                  } else {
                    print("Category contains goals!");
                    Navigator.of(context).pop(DialogsAction.yes);
                        showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialogCannotDeleteCategory(context));
                  }
                  // (hasGoal != 'true') ?
                  // await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(category).delete().whenComplete(() {
                  //       //print("$category deleted "); 
                  //       Navigator.of(context).pop(DialogsAction.yes);
                  //       showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) => _buildPopupDialogDeleteCategory(context) ,
                  //         ); 
                  //       }): 
                  //       Navigator.of(context).pop(DialogsAction.yes);
                  //       showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) => _buildPopupDialogCannotDeleteCategory(context)
                  //        ,
                  //         ); 

                          
                        //final action = await AlertDialogsCat.yesCancelDialog(context, _category.category.toString(), _category.hasGoal.toString(), 'Delete Category', 'Are you sure you want to delete ');
                  
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

  static _buildPopupDialogDeleteCategory(BuildContext context) {
    return AlertDialog(
    title: const Text('Successfully deleted a Category!'),
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

  static _buildPopupDialogCannotDeleteCategory(BuildContext context) {
    return AlertDialog(
    title: const Text('Category contains goals!'),
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

// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/screens/profile.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel}

class AlertDialogs {

  final uid = FireAuth().currentUser?.uid;

  Future<String?> searchUsername(String? uid) async {
    final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
    String username = docRef.get("username");
    return username;
  }
  
  Future<String?> searchUID(String? username) async {
    String? username = await searchUsername(uid);
    String? uidFriend;
    if(username!.isNotEmpty){
      await FirebaseFirestore.instance.collection('UserData')
            .where("username", isEqualTo: username)
            .get()
            .then((value) {
              uidFriend = value.docs.first.id;
              print(uidFriend);
            });
    }
    return uidFriend;
  }

  Future<bool> requestAlreadySent(String uidUser) async{
    bool result = false;
    String? username = await searchUsername(uid);
    if(uidUser.isNotEmpty){
      await FirebaseFirestore.instance.collection('UserData').doc(uidUser).collection('notifications')
            .where("fromUser", isEqualTo: username)//from current user
            .where("typeNotif",isEqualTo: 0)//a friend request
            .get()
            .then((value) {
              if(value.size>=1){
                result = true;
              }
            });
    }
    print(result);
    return result;
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
              child: Text(
                'Confirm', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
              );
              }
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

  static Future<DialogsAction> AcceptFriendDialog(
    BuildContext context,
    String username,
    String uidFriend,
    String title,
  ) async {
    String body = 'Are you sure you want to accept ';
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(body + '\'' + username + '\'''s friend request?'),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async { 
                  final uid = FireAuth().currentUser?.uid;
                  // var userUsername = 
                  final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
                  String userUsername = docRef.get("username");
                //USER SIDE
                  //DELETE NOTIF
                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('notifications').doc(uidFriend).delete().whenComplete(() {
                        print("$username accepted"); 
                        });
                  //ADD FRIEND TO FRIENDS LIST
                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('friends').doc(uidFriend).set({
                    "username": username,
                  }).whenComplete(() {
                      print("$username added to your friends list");
                        });

                //FRIENDS SIDE
                  //ADD USER TO FRIENDS LIST
                  await FirebaseFirestore.instance.collection('UserData').doc(uidFriend).collection('friends').doc(uid).set({
                    "username": userUsername,
                  }).whenComplete(() {
                      print("You are added to $username's friends list");
                        });
                  //ADD NOTIF OF ACCEPTED REQUEST IN FRIENDS SIDE
                  await FirebaseFirestore.instance.collection('UserData').doc(uidFriend).collection('notifications').doc(uid).set({
                    "notifMessage": '$userUsername accepted your friend request',
                    "fromUser": userUsername,
                    "ago": Timestamp.now(),
                    "uidSender": uid,
                    "typeNotif": 1,
                  }).whenComplete(() {
                      print("$username is notified");
                        });
                  
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

  static Future<DialogsAction> RejectFriendDialog(
    BuildContext context,
    String username,
    String uidFriend,
    String title,
  ) async {
    String body = 'Are you sure you want to reject ';
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(body + '\'' + username + '\'''s friend request?'),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async { 
                  final uid = FireAuth().currentUser?.uid;
                  final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
                  String userUsername = docRef.get("username");

                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('notifications').doc(uidFriend).delete().whenComplete(() {
                        print("$username's request is deleted"); 
                        });

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

  static Future<DialogsAction> RemoveNotifDialog(
    BuildContext context,
    String username,
    String uidFriend,
    String title,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async { 
                  final uid = FireAuth().currentUser?.uid;
                  final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
                  String userUsername = docRef.get("username");
                  print(uidFriend);
                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('notifications').doc(uidFriend).delete().whenComplete(() {
                        print("Notification Removed"); 
                        });

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

  static Future<DialogsAction> RemoveFriendDialog(
    BuildContext context,
    String username,
    String title,
  ) async {
    
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async { 
                  final uid = FireAuth().currentUser?.uid;
                  final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
                  String userUsername = docRef.get("username");
                  String? uidFriend;
                  Map? friend;
                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('friends')
                    .where("username", isEqualTo: username)
                    .get()
                    .then((value) {
                      uidFriend = value.docs.first.id;
                      for (var i in value.docs){
                        friend = i.data();
                      }
                      
                    });
                  print(friend);
                  print(uidFriend);
                  
                  //REMOVE FRIEND FROM USER FRIENDS LIST
                  await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('friends').doc(uidFriend).delete().whenComplete(() {
                        print("Friend is removed in your friends list"); 
                        });

                  //REMOVE USER FROM FRIEND's FRIENDS LIST
                  await FirebaseFirestore.instance.collection('UserData').doc(uidFriend).collection('friends').doc(uid).delete().whenComplete(() {
                        print("User is removed in your friend's list"); 
                        });

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

  static Future<DialogsAction> AddFriendDialog(
    BuildContext context,
    String username,
    String uidFriend,
    String title,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(title + username + '?'),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () async { 
                  final uid = FireAuth().currentUser?.uid;
                  // var userUsername = 
                  final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
                  String userUsername = docRef.get("username");
                //FRIEND SIDE
                  //ADD NOTIF OF FRIEND REQUEST IN FRIENDS SIDE
                  print('Add Friend uid $uidFriend');
                  await FirebaseFirestore.instance.collection('UserData').doc(uidFriend).collection('notifications').doc(uid).set({
                    "notifMessage": '$userUsername sent a friend request',
                    "fromUser": userUsername,
                    "ago": Timestamp.now(),
                    "uidSender": uid,
                    "typeNotif": 0,
                  }).whenComplete(() {
                      print("Friend Request sent to $username");
                        });
                  
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



  // static Future<DialogsAction> EditGoalDialog(
  //   BuildContext context,
  //   String username,
  //   String uidFriend,
  //   String title,
  // ) async {
  //   String body = 'Are you sure you want to reject ';
  //   final action = await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context){
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  //         title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
  //         content: Text(body + '\'' + username + '\'''s friend request?'),
  //         actions: <Widget>[
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //             onPressed: () async { 
  //                 final uid = FireAuth().currentUser?.uid;
  //                 final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
  //                 String userUsername = docRef.get("username");

  //                 await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('notifications').doc(uidFriend).delete().whenComplete(() {
  //                       print("$username's request is deleted"); 
  //                       });

  //                 Navigator.of(context).pop(DialogsAction.yes);},
  //             child: Text(
  //               'Confirm', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           RaisedButton(
  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //             onPressed: () => 
  //                 Navigator.of(context).pop(DialogsAction.cancel) ,
  //             child: Text(
  //               'Cancel', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
  //             ),
  //           )
  //         ],
  //       );
  //     }
  //   );
  //   return (action != null) ? action : DialogsAction.cancel;
  // }
}

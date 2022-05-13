// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/alert_dialog.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/models/notification.dart';
String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}

class NotifCard extends StatelessWidget {
  final NotificationEntity _notif;
  final uid = FireAuth().currentUser?.uid;

  NotifCard(this._notif);


  

  @override
  Widget build(BuildContext context) {
    DateTime convertedAgo = _notif.ago.toDate();
    String ago = timeAgo(convertedAgo);
    if(_notif.typeNotif==0){//if friend request
    return Container(
            // width: MediaQuery.of(context).size.width,
            width: 647,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                  width: 340,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                IconButton(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  icon: Icon(Icons.person, size: 50.0, color: const Color.fromRGBO(100, 88, 204, .9)),
                                  onPressed: (){},
                                ),

                                Container(
                                  width: 250,
                                  padding: EdgeInsets.symmetric(horizontal: 00.0, vertical: 10.0),
                                    child: Text(
                                      _notif.notifMessage.toString(),
                                      style: TextStyle(color: Color.fromARGB(255, 72, 68, 80), fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.bold, letterSpacing: 1.1), textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,),
                                ),
                                ]
                              ),


                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                    child: Text(
                                      ago, 
                                      style: TextStyle(color: Color.fromARGB(255, 72, 68, 80), fontSize: 12.0, fontFamily: 'Poppins', fontWeight: FontWeight.normal), textAlign: TextAlign.left,),
                                  ),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.fromLTRB(100, 10, 0, 0),
                                    icon: Icon(Icons.check_rounded, size: 25.0),

                                    onPressed: () async {
                                      final action = await AlertDialogs.AcceptFriendDialog(context, _notif.fromUser.toString(), _notif.uidSender.toString(), 'Accept Request');
                                    },
                                  ),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    icon: Icon(Icons.clear_rounded, size: 25.0),

                                    onPressed: () async{
                                      final action = await AlertDialogs.RejectFriendDialog(context, _notif.fromUser.toString(), _notif.uidSender.toString(), 'Reject Request');
                                    },
                                  )
                                ]
                              ),

                            ],
                          ),
                            ],
                          ),
                        ],
                      )
                    ),
                  )
              );
    }
    else{//if friend request result
      return Container(
            // width: MediaQuery.of(context).size.width,
            width: 647,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                  width: 340,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                IconButton(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  icon: Icon(Icons.person, size: 50.0, color: const Color.fromRGBO(100, 88, 204, .9)),
                                  onPressed: (){},
                                ),

                                Container(
                                  width: 250,
                                  padding: EdgeInsets.symmetric(horizontal: 00.0, vertical: 10.0),
                                    child: Text(
                                      _notif.notifMessage.toString(),
                                      style: TextStyle(color: Color.fromARGB(255, 72, 68, 80), fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.bold, letterSpacing: 1.1), textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,),
                                ),
                                ]
                              ),


                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                    child: Text(
                                      ago, 
                                      style: TextStyle(color: Color.fromARGB(255, 72, 68, 80), fontSize: 12.0, fontFamily: 'Poppins', fontWeight: FontWeight.normal), textAlign: TextAlign.left,),
                                  ),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.fromLTRB(110, 10, 0, 0),
                                    icon: Icon(Icons.clear_rounded, size: 25.0),

                                    onPressed: () async{
                                      final action = await AlertDialogs.RemoveNotifDialog(context, _notif.fromUser.toString(), _notif.uidSender.toString(), 'Request Accepted');
                                    },
                                  )
                                ]
                              ),

                            ],
                          ),
                            ],
                          ),
                        ],
                      )
                    ),
                  )
              );
    }  
  }
}

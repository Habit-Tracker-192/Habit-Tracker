// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:first_app/components/notif_card.dart';
import 'package:first_app/models/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:first_app/screens/searchUser.dart';


class Notif extends StatefulWidget {
  const Notif ({Key? key}) : super(key: key);


  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<Notif> {
  @override
  Widget build(BuildContext context) => DefaultTabController (
      length: 1,
      child: Scaffold(
          appBar: (PreferredSize(
            preferredSize: Size.fromHeight(85.0),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 154, 153, 238),
              title: Container(
                child: IconButton(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.fromLTRB(350, 15, 0, 0),
                  icon: Icon(Icons.search_rounded, size: 30.0),

                  onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchUser()));
                  },
                ),
              ),
              bottom: TabBar(
                padding: EdgeInsets.fromLTRB(0,0,5,0),
                isScrollable: true,
                labelStyle: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                    fontSize: 15.5, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
                tabs: [
                  Tab(text: 'Notifications'),
                ],
              ),
            ),
          )),
          body: TabBarView(
            children: [
              Notifs()
            ],)
      )
  );
}

class Notifs extends StatefulWidget {
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notifs> {

  // List goal = ["@CalebBunye accepted your friend request.", "@DenCute sent you a friend request.", "Take / Fix Notes", "Exercise", "Read Books"];

  // List progress = [20, 35, 15, 35, 54];
  // List total = [20, 50, 20, 50, 90];
  List<Object> _notif = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getNotifList();
  }

  Future getNotifList() async {
    final uid = FireAuth().currentUser?.uid;
    var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uid)
      .collection('notifications')
      .get();
    setState(() {
      _notif = List.from(data.docs.map((doc)=> NotificationEntity.fromSnapshot(doc)));
    });
    print(_notif);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        itemCount: _notif.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>NotifCard(_notif[index] as NotificationEntity)
            )
        );
}

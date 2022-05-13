
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/goal_card.dart';
import 'package:first_app/models/goalList.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'categDetail.dart';
import 'package:first_app/components/friends_goals.dart';
import 'dart:developer';
import 'package:first_app/models/friend.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> usernames = [];
  List<String> names = [];

  final uid = FireAuth().currentUser?.uid;

  @override
  Widget build(BuildContext context) => DefaultTabController (
    length: 2,
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(320.0),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.logout_rounded,
              size: 35,
              color: Color.fromRGBO(64, 64, 64, 1),// add custom icons also
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.mode_edit_rounded,
                  size: 30,
                  color: Color.fromRGBO(64, 64, 64, 1),
                    ),
                )
            ) 
          ],
            
          backgroundColor: const Color.fromARGB(255, 176,156,220),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height:170,
                width: 170,
                child: CircleAvatar(backgroundImage: AssetImage('assets/images/default_profile.png'))
              ),

              const SizedBox(//for spacing purposes
                height: 5,
              ),

              const Text('John Caleb Bunye',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white,
                letterSpacing: 1.0,
                ),
              ),

              const Text('@calebunbun',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                letterSpacing: 1.0,
                ),
              ),

              const SizedBox(//for spacing purposes
                height: 10,
              ),

              Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                height: 42.0,
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 7.0),
                width: 360,
                child: const Text('CS student na pagod na <3',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Color.fromRGBO(100, 88, 204, 1),
                  letterSpacing: 1.0,
                  )
                )
              )
            ],
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
            tabs: [
              Tab(text: 'My Profile'),
              Tab(text: 'Friends'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        children: [
          MyProfile(),
          Friends(),
        ],)
    )
  );
}

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {  //RECENT TAB
  // List goal = ["Exercise", "Read Books", "Journaling"];
  // List goalcategory = ["Health", "Recreation", "Recreation"];
  // List progress = [35, 54, 20];
  // List total = [50, 90, 20];
  // List category = ["Education", "Health"];
  // List categProgress = [200, 150];
  // List categTotal = [250, 200];
  List<Object> _goals = [];
  
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getGoalList();
  }


  Future getGoalList() async {
    final uid = FireAuth().currentUser?.uid;

    var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uid)
      .collection('goals')
      .orderBy('lastlog', descending: true)
      .limit(4)
      .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container( //CATEGORY TEXT
            height: 27,
            alignment: Alignment.centerLeft,
            child: const Text('    Recent Log', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
          ),
          Container(  //RECENT GOALS LISTVIEW
            height: 250,
            child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0,0,0,0),
            itemCount: _goals.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => GoalCard(_goals[index] as GoalEntity)
            ),
          ),
      ])
    )
  );
}

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final uid = FireAuth().currentUser?.uid;
  List<Object> _goals = [];
  List<dynamic> _friendsList = [];
  String? uidFriend;
  List<Object> _goalsFriends = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getGoalList();
    getFriendsList();
    getFriendGoalList();
  }

  Future getGoalList() async {
    final uid = FireAuth().currentUser?.uid;

    var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uid)
      .collection('goals')
      .orderBy('lastlog', descending: true)
      .limit(4)
      .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
    print('goals $_goals');
  }

  Future getFriendGoalList() async {
    final uid = FireAuth().currentUser?.uid;
    var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uidFriend)
      .collection('goals')
      .orderBy('lastlog', descending: true)
      .limit(4)
      .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
    print('goalsFriends $_goals');
  }

  Future getFriendsList() async {
    final uid = FireAuth().currentUser?.uid;

    var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uid)
      .collection('friends')
      .get();
    setState(() {
      _friendsList = List.from(data.docs.map((doc)=> FriendEntity.fromSnapshot(doc)));
    });
    print('friendslist $_friendsList');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    
    body: SafeArea(
      child: 
      Column(
        children: [
        Container( //Friends Logs 
          height: 27,
          alignment: Alignment.centerLeft,
          child: Text('    Friends\' Logs', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
        ),
        // ignore: sized_box_for_whitespace
        Container(
          height:280,
          child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              itemCount: _friendsList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => FriendGoalCard(_goals[index] as GoalEntity,_friendsList[index] as FriendEntity)
          ),
        ),
        ]
    ),
    )
  );
}



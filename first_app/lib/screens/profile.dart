
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/alert_dialog.dart';
import 'package:first_app/components/goal_card.dart';
import 'package:first_app/models/goalList.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/screens/login.dart';
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
  final username = FireAuth().currentUser?.displayName;
  String? _bio = '';
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getBio();
  }

  Future getBio() async {
    final uid = FireAuth().currentUser?.uid;
    final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
    _bio = docRef.get("bio");
     setState(() {
      _bio = _bio;
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController (
    
    length: 2,
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300.0),
        child: AppBar(
          leading:  Container(
            child: IconButton(
              alignment: Alignment.topRight,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              icon: Icon(Icons.logout_rounded, size: 30.0,color: Color.fromRGBO(64, 64, 64, 1)),


              onPressed: () async {
                  await FireAuth.signOut();
                  Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (builder) => Login()), (route) => false);
              },
            ),),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                  icon:
                  Icon(Icons.mode_edit_rounded,size: 30,color: Color.fromRGBO(64, 64, 64, 1),), 
                  onPressed: () async {
                    await AlertDialogs.EditProfileDialog(context,  'Edit your bio');
                    setState(() {
                      _bio = _bio;
                    });
                  },
                ),
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

              Text(username!,
              style: const TextStyle(
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
                child: Text(_bio!,
                  style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Color.fromARGB(255, 1, 0, 8),
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
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
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
  List<GoalEntity> _goalsList=[];
  List<String?> _userList = [];
  late final Future? myFuture = getFuture();
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    // getFriendsList();
    // getGoalList();
    // getFriendGoalList();
  }
  Future<List<GoalEntity>> getFuture()async{
    await getFriendsList();
    var lst = await getFriendGoalList();
    return lst;
  }
  Future<String?> searchUID(String? username) async {
    String? uidFriend;
    if(username!.isNotEmpty){
      await FirebaseFirestore.instance.collection('UserData')
            .where("username", isEqualTo: username)
            .get()
            .then((value) {
              uidFriend = value.docs.first.id;
              // print('uidFriend is $uidFriend');
            });
    }
    return uidFriend;
  }


  Future<List<GoalEntity>> getFriendGoalList() async {
    final uid = FireAuth().currentUser?.uid;
    String? uidFriend;
    _goalsList = [];
    for (FriendEntity o in _friendsList){
      // print(o.username);
      uidFriend = await searchUID(o.username);
      var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uidFriend)
      .collection('goals')
      .orderBy('lastlog', descending: true)
      .limit(2)
      .get();
      setState(() {
      _userList.addAll(data.docs.map((doc)=> o.username)) ;
      _goalsList.addAll(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
      });
    }
    // print(_userList);
    return _goalsList;
    // print(_goalsList);
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
    // print(_goalsList);
    // getFriendGoalList();
    // return _friendsList;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: 
      Column(
        children: [
        Container( //Friends Logs 
          height: 27,
          alignment: Alignment.centerLeft,
          child: const Text('    Friends\' Logs', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
        ),
        // ignore: sized_box_for_whitespace
        Container(
          height:290,
          child: FutureBuilder(
            future: myFuture,
            // Future.wait([getFriendsList(),getFriendGoalList(),getGoalList()]),
            builder: (context, snapshot) {
              final error = snapshot.error;
              if (snapshot.hasError){
                return Text('Server encountered an error');
              }
              else if(snapshot.hasData){
                // return Text('gumagana');
                return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                    itemCount: _goalsList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => FriendGoalCard(_goalsList[index], _userList[index])
                    );
              }
              else{
                return Container(
                  height: 50,
                  width: 50,
                  child: const CircularProgressIndicator(),
                );
                
              }
            }
          
          )
          // ListView.builder(
          //     padding: const EdgeInsets.fromLTRB(0,0,0,0),
          //     itemCount: _friendsList.length,
          //     shrinkWrap: true,
          //     itemBuilder: (BuildContext context, int index) => FriendGoalCard(_goals[index] as GoalEntity,_friendsList[index] as FriendEntity)
          // ),
        ),
        ]
    ),
    )
  );
}



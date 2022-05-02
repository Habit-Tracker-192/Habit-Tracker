
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/goal_card.dart';
import 'package:first_app/models/goalList.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'categDetail.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);



  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  

  final FireAuth auth = FireAuth();

  List<String> usernames = [];
  List<String> names = [];

  @override
  Widget build(BuildContext context) => DefaultTabController (
    length: 2,
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300.0),
        child: AppBar(
          //backgroundColor: Color.fromARGB(255, 154, 153, 238),
          title: Container(
            child: IconButton(
              alignment: Alignment.topRight,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              icon: Icon(Icons.logout_rounded, size: 30.0,color: Color.fromRGBO(64, 64, 64, 1)),
              

              onPressed: () async {
                
                  await FireAuth.signOut();
                  // Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => Login()));
                  Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (builder) => Login()), (route) => false);
                //}
                //);
                
              },
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

              const Text('Louise Denise Bacani',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white,
                letterSpacing: 1.0,
                ),
              ),

              const Text('@dencute',
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
          SizedBox(height: 5),
          Container( //RECENT LOG TEXT
            height: 45,
            alignment: Alignment.centerLeft,
            child: Text('    Recent Log', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
          ),
          Container(  //RECENT GOALS LISTVIEW
            height: 280,
            child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0,5,0,0),
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

  List goal = ["Watch CS 21 Lectures", "Study CS 191", "Take / Fix Notes", "Exercise", "Read Books"];
  List goalcategory = ["Education", "Education", "Education", "Health", "Recreation"];
  List progress = [54, 35, 15, 35, 54];
  List total = [90, 50, 20, 50, 90];
  List<String> friendsList = ['@zayruh','@zayruh','@DenCute','@DenCute','@DenCute'];


  @override
  Widget build(BuildContext context) => Scaffold(
    
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 5),
        Container(
           //Friends Logs 
          height: 47,
          //padding: EdgeInsets.fromLTRB(0,15,0,0),
          alignment: Alignment.centerLeft,
          child: Text('    Friends\' Logs', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
        ),
        Container(
          height:280,
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0,5,0,0),
              itemCount: goal.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container( //CATEGORY TEXT
                                  height: 15,
                                  alignment: Alignment.centerLeft,
                                  child: Text(friendsList[index], style: TextStyle(fontSize: 12, fontFamily: 'Poppins'))
                                ),
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(goal[index], style: TextStyle(color: 
                                      Color.fromARGB(255, 72, 68, 80), fontSize: 
                                      18.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                                      letterSpacing: 1.1),),
                                    
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(left:30),
                                      icon: Icon(Icons.edit, size: 15.0),

                                      onPressed: (){},
                                    ),  
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      icon: Icon(Icons.clear_rounded, size: 15.0),

                                      onPressed: (){},
                                    ),    
                                ],),
                              
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,7),
                                      child: Text(goalcategory[index], style: TextStyle(color: 
                                      Color.fromARGB(255, 94, 93, 189), fontStyle: FontStyle.italic,
                                        fontFamily: 'Poppins', fontWeight: FontWeight.bold, 
                                        fontSize: 13.0, letterSpacing: 1.0)),
                                    ),
                                    
                                    Center(child:
                                      SizedBox(width: 190)
                                    ),
                                    
                                    Text(((progress[index]/total[index])*100).toInt().toString() 
                                        + '%', style: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                                        fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3)),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,10),
                                  child: LinearPercentIndicator( //Recent Goal linear percent bar
                                    width: 300,
                                    animation: true,
                                    lineHeight: 15,
                                    center: Row(
                                      
                                      children: [
                                        Text(progress[index].toString(), style: TextStyle(fontSize: 12, color:
                                        Color.fromARGB(255, 228, 223, 238))),
                                        Center(child:
                                          SizedBox(width: 240)
                                        ),
                                        Text(total[index].toString(), style: TextStyle(fontSize: 12, color:
                                        Color.fromARGB(255, 143, 141, 150))),
                                      ],
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    percent: progress[index]/total[index],
                                    progressColor: Color.fromARGB(255, 104, 106, 207),
                                    backgroundColor: Color.fromARGB(255, 228, 223, 238),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                )
              ),
          ),
        ),
        ]
    ),
    )
   
  );
}


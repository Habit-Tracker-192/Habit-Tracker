
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:first_app/components/alert_dialog.dart';
import 'package:first_app/components/alert_dialog_cat.dart';
import 'package:first_app/components/goal_card.dart';
import 'package:first_app/models/goalList.dart';
import 'package:first_app/screens/searchGoal.dart';
import 'package:flutter/material.dart';
import '../components/categ_card.dart';
import '../models/categList.dart';
import 'categDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/services/authenticate.dart';

class Goal extends StatefulWidget {
  const Goal({Key? key}) : super(key: key);


  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  @override
  Widget build(BuildContext context) => DefaultTabController (
    length: 4,
    child: Scaffold(
      appBar: (PreferredSize(
        preferredSize: Size.fromHeight(85.0),
        child: AppBar(
        backgroundColor: Color.fromARGB(255, 154, 153, 238),
        title: Container(
          child: IconButton(
            alignment: Alignment.topRight,
            padding: EdgeInsets.fromLTRB(270, 15, 0, 0),
            icon: Icon(Icons.search_rounded, size: 30.0),

            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchGoal()));
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
            Tab(text: 'Recent'),
            Tab(text: 'In Progress'),
            Tab(text: 'Completed'),
            Tab(text: 'All'),
          ],
        ),
      )
      ))
      ,
      body: TabBarView(
        children: [
          Recent(),
          InProgress(),
          Completed(),
          All(),
          //Completed(),
          //All(),
        ],)
    )
  );
}


class Recent extends StatefulWidget {
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {  //RECENT TAB

  // List goal = ["Exercise", "Read Books", "Journaling"];
  // List goalcategory = ["Health", "Recreation", "Recreation"];
  // List progress = [35, 54, 20];
  // List total = [50, 90, 20];
  // List category = ["Education", "Health"];
  // List categProgress = [200, 150];
  // List categTotal = [250, 200];
  List<Object> _goals = [];
  List<Object> _categories = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getGoalList();
    getCategoryList();
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
  Future getCategoryList() async {
    final uid = FireAuth().currentUser?.uid;

    var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uid)
      .collection('categories')
      .orderBy('category')
      //.limit(1)
      .get();
    setState(() {
      _categories = List.from(data.docs.map((doc)=> CategoryEntity.fromSnapshot(doc)));
    });
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(  //RECENT GOALS LISTVIEW
            height: 300,
            child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            itemCount: _goals.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) =>  GoalCard(_goals[index] as GoalEntity)
            ),
          ),
          Container( //CATEGORY TEXT
            height: 30,
            alignment: Alignment.centerLeft,
            child: Text('    Categories', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
          ),

          Container(    //CATEGORY LISTVIEW
            height: 200,
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (BuildContext ctx, int index){
                return GestureDetector(
                onTap: () async { 
                  await
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => categDetail(_categories[index] as CategoryEntity)),
                  );
                },
                
                child:  CategoryCard(_categories[index] as CategoryEntity)  
                ); 
              }
            )
          )
      ,])
    )
  );
}


class InProgress extends StatefulWidget {
  _InProgressState createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
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
      .where("percent", isLessThan: 100)
      .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }
  


  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          itemCount: _goals.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => GoalCard(_goals[index] as GoalEntity) 
  ));
}

class Completed extends StatefulWidget {
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
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
      .where("percent", isEqualTo: 100)
      .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          itemCount: _goals.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => GoalCard(_goals[index] as GoalEntity) 
          )
   
  );
}

class All extends StatefulWidget {
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
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
      .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: null,
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('userData').doc(FireAuth().currentUser?.uid).collection('goals').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          itemCount: _goals.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => GoalCard(_goals[index] as GoalEntity)
        );},
    ),
  );
}

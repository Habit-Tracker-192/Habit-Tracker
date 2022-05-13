import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/goal_card2.dart';
import 'package:first_app/models/goalList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:date_format/date_format.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) => DefaultTabController (
      length: 3,
      child: Scaffold(
          appBar:
          (PreferredSize(
            preferredSize: Size.fromHeight(202.0),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/design_2.png'),
                    fit: BoxFit.cover

                  ),
                ),

                child: Container(

                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.fromLTRB(1.0, 110.0, .0, 100.0),
                  width: 500,
                  child: Text(DateFormat.yMd().format(currentTime),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 27.0,
                        color: Colors.white,
                    ),
                  ),

                ),
                ),
              backgroundColor: Color.fromARGB(255, 154, 153, 238),
              title: Container(
                child: IconButton(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.fromLTRB(350, 15, 0, 0),
                  icon: Icon(Icons.search_rounded, size: 30.0),

                  onPressed: (){},
                ),
              ),
              bottom: const TabBar(
                padding: EdgeInsets.fromLTRB(0,0,5,0),
                isScrollable: true,
                labelStyle: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                    fontSize: 15.5, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
                tabs: [
                  Tab(text: 'Daily'),
                  Tab(text: 'Weekly'),
                  Tab(text: 'Monthly'),
                ],
              ),
            ),
          )),
          body: TabBarView(
            children: [
              Daily(),
              Weekly(),
              Monthly(),
            ],)
      )
  );
}

class Daily extends StatefulWidget {
  _DailyState createState() => _DailyState();
}
class _DailyState extends State<Daily> {
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
        .where('frequency', isEqualTo: "Daily")
        .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: _goals.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => GoalCard2(_goals[index] as GoalEntity)
      )
  );
}

class Weekly extends StatefulWidget {
  _WeeklyState createState() => _WeeklyState();
}
class _WeeklyState extends State<Weekly> {
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
        .where('frequency', isEqualTo: "Weekly")
        .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: _goals.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => GoalCard2(_goals[index] as GoalEntity)
      )
  );
}

class Monthly extends StatefulWidget {
  _MonthlyState createState() => _MonthlyState();
}
class _MonthlyState extends State<Monthly> {
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
        .where('frequency', isEqualTo: "Monthly")
        .get();
    setState(() {
      _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: _goals.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => GoalCard2(_goals[index] as GoalEntity)
      )
  );
}


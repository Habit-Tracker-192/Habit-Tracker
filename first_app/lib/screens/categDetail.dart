// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/categGoal_card.dart';
import 'package:first_app/components/categ_card.dart';
import 'package:first_app/components/goal_card.dart';
import 'package:first_app/models/categGoalList.dart';
import 'package:first_app/models/categList.dart';
import 'package:first_app/models/goalList.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/foundation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';


class categDetail extends StatefulWidget {
  final CategoryEntity _category;
  const categDetail(this._category);
  
  _categDetailState createState() => _categDetailState();
}

class _categDetailState extends State<categDetail> { 
  
  List<Object> _categGoals = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getCategGoalList();
  }

  Future getCategGoalList() async {
    final uid = FireAuth().currentUser?.uid;
    var data = await FirebaseFirestore.instance
      .collection('UserData')
      .doc(uid)
      .collection('categories')
      .doc(widget._category.category.toString())
      .collection('goals')
      //.where("goalcategory", isEqualTo: 'Education')
      .get();
      
    setState(() {
      _categGoals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              IconButton(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(left:5),
                icon: Icon(Icons.keyboard_arrow_left_rounded, size: 30.0),

                onPressed: (){
                  Navigator.pop(context);
                },
              ),  
              
              IconButton(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(310, 0, 0, 20),
                icon: Icon(Icons.search_rounded, size: 30.0),

                onPressed: (){},
              ),    
          ],),
          Container( //CATEGORY TEXT
            height: 30,
            alignment: Alignment.centerLeft,
            child: Text('     '+ widget._category.category.toString(), style: TextStyle(fontSize: 20, fontFamily: 'Poppins',
            fontWeight: FontWeight.bold, color: Color.fromARGB(255, 72, 68, 80)))
          ),

          Container( //CATEGORY TEXT
            height: 30,
            alignment: Alignment.centerLeft,
            child: Text('     Target hours: ' + widget._category.categTargetHours.toString() + " hrs", style: TextStyle(fontSize: 18, fontFamily: 'Poppins',
            color: Color.fromARGB(255, 94, 93, 189), fontStyle: FontStyle.italic))
          ),

          Container(  //RECENT GOALS LISTVIEW
            height: 300,
            child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            itemCount: _categGoals.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) =>  GoalCard(_categGoals[index] as GoalEntity) 
            ),
          ),
        ]),
      ),
    );
  }
}

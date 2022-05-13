// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/alert_dialog.dart';
import 'package:first_app/models/friend.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/goalList.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FriendGoalCard extends StatefulWidget {
  final GoalEntity _goal;
  final FriendEntity _friend;
  FriendGoalCard(this._goal, this._friend);
  

  @override
  State<FriendGoalCard> createState() => _FriendGoalCardState();
}

class _FriendGoalCardState extends State<FriendGoalCard> {
  final uid = FireAuth().currentUser?.uid;


  @override
  Widget build(BuildContext context) {
    return
    Container(
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
                    children: <Widget>[
                      Container(//Goal owner
                        height: 15,
                        alignment: Alignment.centerLeft,
                        child: Text(widget._friend.username.toString(), style: TextStyle(fontSize: 12, fontFamily: 'Poppins'))
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget._goal.goal.toString(), style: TextStyle(color: 
                            Color.fromARGB(255, 72, 68, 80), 
                            fontSize: 18.0, 
                            fontWeight: FontWeight.bold, 
                            fontFamily: 'Poppins',
                            letterSpacing: 1.1),),    
                      ],),
                              
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,7),
                            child: Text(widget._goal.goalcategory.toString(), style: TextStyle(color: 
                            Color.fromARGB(255, 94, 93, 189), fontStyle: FontStyle.italic,
                              fontFamily: 'Poppins', fontWeight: FontWeight.bold, 
                              fontSize: 13.0, letterSpacing: 1.0)),
                            ),
                                    
                          Center(child:
                            SizedBox(width: 210)
                          ),
                                    
                          Text(
                              widget._goal.percent.toString() + '%', 
                              style: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
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
                              Text(widget._goal.progress.toString(), style: TextStyle(fontSize: 12, color:
                              Color.fromARGB(255, 228, 223, 238))),
                              Center(child:
                                SizedBox(width: 260)
                              ),
                              Text(widget._goal.total.toString(), style: TextStyle(fontSize: 12, color:
                              Color.fromARGB(255, 143, 141, 150))),
                            ],
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          percent: widget._goal.progress/widget._goal.total,
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
    );
  }
  
}

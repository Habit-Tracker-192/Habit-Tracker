// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/alert_dialog.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/goalList.dart';
import 'package:percent_indicator/percent_indicator.dart';


class GoalCard2 extends StatefulWidget {
  final GoalEntity _goal;

  GoalCard2(this._goal);

  @override
  State<GoalCard2> createState() => _GoalCard2State();
}

class _GoalCard2State extends State<GoalCard2> {
  //int currentCount = _goal.progress;

  final uid = FireAuth().currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    int currentProgress = int.parse(widget._goal.progress.toString());
      return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),

            child: Container(
                width: MediaQuery.of(context).size.width,
                //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:  Color.fromRGBO(255, 255, 255, .5),
                    ),
                  ],
                ),
                child: CircularPercentIndicator(
                  radius: 150,
                  animation: true,
                  //strokeWidth: 10,
                  lineWidth: 10,

                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width:15),
                      Text(widget._goal.goal.toString(), style: TextStyle(color:
                      Color.fromARGB(255, 72, 68, 80),
                          fontSize: 15.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                        textAlign: TextAlign.justify,
                      ),
                      IconButton(alignment: Alignment.center,
                        icon: Icon(Icons.add, size: 25.0, color: Color.fromARGB(255, 72, 68, 80)),
                          onPressed: () async {
                              setState(() {
                              if (widget._goal.progress < widget._goal.total) {
                                currentProgress++; 
                                widget._goal.progress = widget._goal.progress+1;
                              }
                              else {}});
                              var goalID = widget._goal.goal;
                              //update percent, progress, and lastlog
                              await FirebaseFirestore.instance.collection(
                                  'UserData').doc(FireAuth().currentUser?.uid)
                                  .collection('goals').doc(goalID)
                                  .update({'progress': widget._goal.progress, 'lastlog': Timestamp.now(), 'percent':(widget._goal.progress/widget._goal.total)*100});

                              //update category progress in goal list
                              final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(widget._goal.goalcategory).get();
                              num currentCategProgress = docRef.get("categProgress");
                              await FirebaseFirestore.instance.collection(
                                  'UserData').doc(uid)
                                  .collection('categories').doc(widget._goal.goalcategory)
                                  .update({'categProgress': currentCategProgress+widget._goal.duration});

                              //update percent,progress, and lastlog  in category list
                              await FirebaseFirestore.instance.collection('UserData').doc(uid)
                                  .collection('categories').doc(widget._goal.goalcategory).collection('goals').doc(goalID)
                                  .update({'percent':(widget._goal.progress/widget._goal.total)*100, 'lastlog': Timestamp.now(), 'progress':widget._goal.progress});
                            }

                            ),
                      Text(widget._goal.duration.toString() + ' hr',
                         style: TextStyle(color:
                              Color.fromARGB(255, 72, 68, 80),
                              fontSize: 15.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0),
                              textAlign: TextAlign.justify,
                       ),
                    ],
                  ),

                  circularStrokeCap: CircularStrokeCap.round,
                  percent: currentProgress/widget._goal.total,
                  progressColor: Color.fromARGB(255, 111, 104, 207),
                  backgroundColor: Color.fromRGBO(201, 196, 246, 1.0),
                ),
            ),
        );
  }
}




// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/alert_dialog.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/goalList.dart';
import 'package:percent_indicator/percent_indicator.dart';


class GoalCard extends StatelessWidget {
  final GoalEntity _goal;
  final uid = FireAuth().currentUser?.uid;

  GoalCard(this._goal);

  @override
  Widget build(BuildContext context) {
    return Container( //return gesturedetector child: container
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
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

                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_goal.goal.toString(), style: TextStyle(color: 
                            Color.fromARGB(255, 72, 68, 80), fontSize: 
                            18.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                            letterSpacing: 1.1),),
                          
                          IconButton(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left:5),
                            icon: Icon(Icons.edit, size: 15.0),
                          
                            onPressed: (){},
                          ),  
                          IconButton(    
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            icon: Icon(Icons.clear_rounded, size: 15.0),

                            onPressed: () async {
                              final action = await AlertDialogs.yesCancelDialog(context, _goal.goal.toString(), _goal.goalcategory.toString(), 'Delete Goal', 'Are you sure you want to delete ');
                            },
                          ),    
                      ],),
                  
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,7),
                            child: Text(_goal.goalcategory.toString(), style: TextStyle(color: 
                            Color.fromARGB(255, 94, 93, 189), fontStyle: FontStyle.italic,
                              fontFamily: 'Poppins', fontWeight: FontWeight.bold, 
                              fontSize: 13.0, letterSpacing: 1.0)),
                          ),
                          
                          Center(child:
                            SizedBox(width: 210)
                          ),
                          
                          Text(((_goal.progress/_goal.total)*100).toInt().toString() 
                              + '%', style: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                              fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                              letterSpacing: 1.3)),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,10),
                        child: LinearPercentIndicator( //Recent Goal linear percent bar
                          width: 335,
                          animation: true,
                          lineHeight: 15,
                          center: Row(
                            
                            children: [
                              Text(_goal.progress.toString(), style: TextStyle(fontSize: 12, color:
                              Color.fromARGB(255, 228, 223, 238))),
                              Center(child:
                                SizedBox(width: 260)
                              ),
                              Text(_goal.total.toString(), style: TextStyle(fontSize: 12, color:
                              Color.fromARGB(255, 143, 141, 150))),
                            ],
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          percent: _goal.progress/_goal.total,
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
    );//return here
  }
}

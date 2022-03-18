// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

class categDetail extends StatelessWidget {

  List goal = ["Watch CS 21 Lectures", "Study CS 191", "Take / Fix Notes"];
  List goalcategory = ["Education", "Education", "Education"];
  List progress = [54, 35, 15];
  List total = [90, 50, 20];

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
                padding: EdgeInsets.fromLTRB(310, 0, 20, 0),
                icon: Icon(Icons.search_rounded, size: 30.0),

                onPressed: (){},
              ),    
          ],),
          Container( //CATEGORY TEXT
            height: 30,
            alignment: Alignment.centerLeft,
            child: Text('     '+ goalcategory[0], style: TextStyle(fontSize: 20, fontFamily: 'Poppins',
            fontWeight: FontWeight.bold, color: Color.fromARGB(255, 72, 68, 80)))
          ),

          Container( //CATEGORY TEXT
            height: 30,
            alignment: Alignment.centerLeft,
            child: Text('     Target hours: 160h', style: TextStyle(fontSize: 18, fontFamily: 'Poppins',
            color: Color.fromARGB(255, 94, 93, 189), fontStyle: FontStyle.italic))
          ),
          Container(  //RECENT GOALS LISTVIEW
            height: 600,
            child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            itemCount: goal.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) =>   
            Container( //return gesturedetector child: container
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

                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(goal[index], style: TextStyle(color: 
                                      Color.fromARGB(255, 72, 68, 80), fontSize: 
                                      18.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                                      letterSpacing: 1.1),),
                                    
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(left:40),
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
                                      SizedBox(width: 210)
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
                                    width: 320,
                                    animation: true,
                                    lineHeight: 15,
                                    center: Row(
                                      
                                      children: [
                                        Text(progress[index].toString(), style: TextStyle(fontSize: 12, color:
                                        Color.fromARGB(255, 228, 223, 238))),
                                        Center(child:
                                          SizedBox(width: 250)
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
              )
            ),
          ),
        ]),
      ),
    );
  }
}
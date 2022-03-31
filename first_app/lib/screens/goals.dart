
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'categDetail.dart';


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
            padding: EdgeInsets.fromLTRB(350, 15, 0, 0),
            icon: Icon(Icons.search_rounded, size: 30.0),

            onPressed: (){},
          ), 
        ),
        bottom: TabBar(
          padding: EdgeInsets.fromLTRB(0,0,5,0),
          isScrollable: true,
          labelStyle: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
            fontSize: 15.5, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
            letterSpacing: 1.0),
          // unselectedLabelStyle: TextStyle(backgroundColor: Color.fromARGB(255, 224, 215, 243),
          //   color: Color.fromARGB(255, 72, 68, 80),
          //   fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
          //   letterSpacing: 1.0),
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

  List goal = ["Exercise", "Read Books", "Journaling"];
  List goalcategory = ["Health", "Recreation", "Recreation"];
  List progress = [35, 54, 20 ];
  List total = [50, 90, 20];
  List category = ["Education", "Health"];
  List categProgress = [200, 150];
  List categTotal = [250, 200];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Container(  //RECENT GOALS LISTVIEW
            height: 300,
            child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            itemCount: goal.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) =>   
            Container( //return gesturedetector child: container
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
                                    Text(goal[index], style: TextStyle(color: 
                                      Color.fromARGB(255, 72, 68, 80), fontSize: 
                                      18.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                                      letterSpacing: 1.1),),
                                    
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(left:145),
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
                                    width: 335,
                                    animation: true,
                                    lineHeight: 15,
                                    center: Row(
                                      
                                      children: [
                                        Text(progress[index].toString(), style: TextStyle(fontSize: 12, color:
                                        Color.fromARGB(255, 228, 223, 238))),
                                        Center(child:
                                          SizedBox(width: 260)
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
          Container( //CATEGORY TEXT
            height: 70,
            alignment: Alignment.centerLeft,
            child: Text('    Categories', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
          ),

          Container(    //CATEGORY LISTVIEW
            height: 150,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext ctx, int index){
                return GestureDetector(
                onTap: () async { await
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => categDetail()),
                  );
                },
                child:    
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  height: 175,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset('assets/images/Education.png', 
                            fit: BoxFit.cover
                          )
                        )
                      ),
                      Positioned(
                        bottom: 6,
                        left: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),

                              Row(
                                children: [
                                  Text(category[index], style: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                                    fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                                    letterSpacing: 1.3)),                            
                                  Center(child:
                                    SizedBox(width: 110)
                                  ),
                                  Text(((categProgress[index]/categTotal[index])*100).toInt().toString() 
                                      + '% completed', style: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                                      fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3)),
                                ],
                              ),
                              
                              Padding(
                                padding: EdgeInsets.fromLTRB(0,7,0,0),
                                child: LinearPercentIndicator(  //Category Linear Percent Indicator
                                  width: 330,
                                  animation: true,
                                  lineHeight: 16,
                                  center: Row(
                                    children: [
                                      Text(categProgress[index].toString(), style: TextStyle(fontSize: 12, color:
                                      Color.fromARGB(255, 228, 223, 238))),
                                      Center(child:
                                        SizedBox(width: 255)
                                      ),
                                      Text(categTotal[index].toString(), style: TextStyle(fontSize: 12, color:
                                      Color.fromARGB(255, 143, 141, 150))),
                                    ],
                                  ),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  percent: categProgress[index]/categTotal[index],
                                  progressColor: Color.fromARGB(255, 61, 68, 95),
                                  backgroundColor: Color.fromARGB(255, 228, 223, 238),
                                ),
                              )
                            ],
                          ),
                        )
                      )
                    ],
                  )
                ));
                
              },
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

  List goal = ["Watch CS 21 Lectures", "Study CS 191", "Take / Fix Notes", "Exercise", "Read Books"];
  List goalcategory = ["Education", "Education", "Education", "Health", "Recreation"];
  List progress = [54, 35, 15, 35, 54];
  List total = [90, 50, 20, 50, 90];


  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          itemCount: goal.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
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
                                Text(goal[index], style: TextStyle(color: 
                                  Color.fromARGB(255, 72, 68, 80), fontSize: 
                                  18.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                                  letterSpacing: 1.1),),
                                
                                IconButton(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(left:50),
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
                                width: 335,
                                animation: true,
                                lineHeight: 15,
                                center: Row(
                                  
                                  children: [
                                    Text(progress[index].toString(), style: TextStyle(fontSize: 12, color:
                                    Color.fromARGB(255, 228, 223, 238))),
                                    Center(child:
                                      SizedBox(width: 260)
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
          )
   
  );
}

class Completed extends StatefulWidget {
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {

  List goal = ["Journaling"];
  List goalcategory = ["Recreation"];
  List progress = [20];
  List total = [20];


  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          itemCount: goal.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
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
                                Text(goal[index], style: TextStyle(color: 
                                  Color.fromARGB(255, 72, 68, 80), fontSize: 
                                  18.0, fontWeight: FontWeight.bold, fontFamily: 'Poppins',
                                  letterSpacing: 1.1),),
                                
                                IconButton(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(left:140),
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
                                width: 335,
                                animation: true,
                                lineHeight: 15,
                                center: Row(
                                  
                                  children: [
                                    Text(progress[index].toString(), style: TextStyle(fontSize: 12, color:
                                    Color.fromARGB(255, 228, 223, 238))),
                                    Center(child:
                                      SizedBox(width: 260)
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
          )
   
  );
}

class All extends StatefulWidget {
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {

  List goal = ["Journaling", "Study CS 191", "Take / Fix Notes", "Exercise", "Read Books"];
  List goalcategory = ["Recreation", "Education", "Education", "Health", "Recreation"];
  List progress = [20, 35, 15, 35, 54];
  List total = [20, 50, 20, 50, 90];


  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView.builder(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          itemCount: goal.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
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
                                  padding: EdgeInsets.only(left:70),
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
                                width: 335,
                                animation: true,
                                lineHeight: 15,
                                center: Row(
                                  
                                  children: [
                                    Text(progress[index].toString(), style: TextStyle(fontSize: 12, color:
                                    Color.fromARGB(255, 228, 223, 238))),
                                    Center(child:
                                      SizedBox(width: 260)
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
          )
   
  );
}

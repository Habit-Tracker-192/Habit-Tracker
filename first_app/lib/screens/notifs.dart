import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'recent.dart';


class Notif extends StatefulWidget {
  const Notif ({Key? key}) : super(key: key);


  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<Notif> {
  @override
  Widget build(BuildContext context) => DefaultTabController (
      length: 1,
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
                tabs: [
                  Tab(text: 'Notifications'),
                ],
              ),
            ),
          )),
          body: TabBarView(
            children: [
              Recent()
              //Completed(),
              //All(),
            ],)
      )
  );
}

class Recent extends StatefulWidget {
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  List goal = ["@CalebBunye accepted your friend request.", "@DenCute sent you a friend request.", "Take / Fix Notes", "Exercise", "Read Books"];

  List progress = [20, 35, 15, 35, 54];
  List total = [20, 50, 20, 50, 90];


  @override
  Widget build(BuildContext context) => Scaffold(
      body: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                  //width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //SizedBox(width: 5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                IconButton(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  icon: Icon(Icons.person, size: 50.0, color: const Color.fromRGBO(100, 88, 204, .9)),
                                  onPressed: (){},
                                ),

                                Container(
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 00.0, vertical: 10.0),
                                    child: Text(
                                      goal[index], style: TextStyle(color: Color.fromARGB(255, 72, 68, 80), fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.bold, letterSpacing: 1.1), textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,),
                                ),
                                ]
                              ),


                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                    child: Text(
                                      "2h", style: TextStyle(color: Color.fromARGB(255, 72, 68, 80), fontSize: 12.0, fontFamily: 'Poppins', fontWeight: FontWeight.normal), textAlign: TextAlign.left,),
                                  ),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.fromLTRB(220, 10, 0, 0),
                                    icon: Icon(Icons.check_rounded, size: 25.0),

                                    onPressed: (){},
                                  ),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    icon: Icon(Icons.clear_rounded, size: 25.0),

                                    onPressed: (){},
                                  )
                                ]
                              ),

                            ],
                          ),



                            ],
                          ),
                        ],
                      )
                    ),
                  )
              ),
            )
        );
}

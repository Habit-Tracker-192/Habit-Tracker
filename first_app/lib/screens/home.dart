import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    image: AssetImage('assets/images/header.png'),
                    fit: BoxFit.cover

                  ),
                ),

                child: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.fromLTRB(1.0, 100.0, .0, 110.0),
                  width: 500,
                  child: const Text('FRIDAY, APRIL 1',
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
              Recent(),
              Recent(),
              Recent(),
            ],)
      )
  );
}

class Recent extends StatefulWidget {
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  List goal = ["Journaling", "Study CS 191", "Rewrite Notes", "Exercise", "Read Books"];
  List category = ["Recreation", "Education", "Education", "Health", "Recreation"];
  List progress = [20, 35, 15, 35, 54];
  List total = [20, 50, 20, 50, 90];


  @override
  Widget build(BuildContext context) => Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: goal.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
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

                                center: Text(goal[index], style: const TextStyle(color:
                                  Color.fromARGB(255, 72, 68, 80), 
                                  fontSize:16.0, 
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold, 
                                  letterSpacing: 1.0), 
                                textAlign: TextAlign.justify,),
                                circularStrokeCap: CircularStrokeCap.round,
                                percent: progress[index]/total[index],
                                progressColor: Color.fromARGB(255, 111, 104, 207),
                                backgroundColor: Color.fromRGBO(201, 196, 246, 1.0),
                                // 255, 111, 104, 207
                        )
              )
        ),

      )
  );
}

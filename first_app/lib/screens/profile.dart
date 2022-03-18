
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'categDetail.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> usernames = [];
  List<String> names = [];

  @override
  Widget build(BuildContext context) => DefaultTabController (
    length: 2,
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(320.0),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.logout_rounded,
              size: 35,
              color: Color.fromRGBO(64, 64, 64, 1),// add custom icons also
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.mode_edit_rounded,
                  size: 30,
                  color: Color.fromRGBO(64, 64, 64, 1),
                    ),
                )
            )
          ],
            
          backgroundColor: const Color.fromARGB(255, 176,156,220),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height:170,
                width: 170,
                child: CircleAvatar(backgroundImage: AssetImage('assets/images/profileImage.png'))
              ),

              const SizedBox(//for spacing purposes
                height: 5,
              ),

              const Text('John Caleb Bunye',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white,
                letterSpacing: 1.0,
                ),
              ),

              const Text('@calebbunye',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                letterSpacing: 1.0,
                ),
              ),

              const SizedBox(//for spacing purposes
                height: 10,
              ),

              Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                height: 42.0,
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 7.0),
                width: 360,
                child: const Text('CS student na pagod na <3',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Color.fromRGBO(100, 88, 204, 1),
                  letterSpacing: 1.0,
                  )
                )
              )
            ],
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
            tabs: [
              Tab(text: 'My Profile'),
              Tab(text: 'Friends'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        children: [
          MyProfile(),
          Friends(),
        ],)
    )
  );
}

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {  //RECENT TAB
  List goal = ["Exercise", "Read Books", "Journaling"];
  List goalcategory = ["Health", "Recreation", "Recreation"];
  List progress = [35, 54, 20];
  List total = [50, 90, 20];
  List category = ["Education", "Health"];
  List categProgress = [200, 150];
  List categTotal = [250, 200];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 5),
          Container( //CATEGORY TEXT
            height: 27,
            alignment: Alignment.centerLeft,
            child: Text('    Recent Log', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
          ),
          Container(  //RECENT GOALS LISTVIEW
            height: 190,
            child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0,0,0,0),
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
            height: 27,
            alignment: Alignment.centerLeft,
            child: Text('    Categories', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
          ),
          Container(    //CATEGORY LISTVIEW
            height: 110,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext ctx, int index){
                return GestureDetector(
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => categDetail()),
                  );
                },
                child:    
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  List goal = ["Watch CS 21 Lectures", "Study CS 191", "Take / Fix Notes", "Exercise", "Read Books"];
  List goalcategory = ["Education", "Education", "Education", "Health", "Recreation"];
  List progress = [54, 35, 15, 35, 54];
  List total = [90, 50, 20, 50, 90];
  List<String> friendsList = ['@zayruh','@zayruh','@DenCute','@DenCute','@DenCute'];


  @override
  Widget build(BuildContext context) => Scaffold(
    
    body: SafeArea(
      child: Column(
        children: [
        Container( //Friends Logs 
          height: 27,
          alignment: Alignment.centerLeft,
          child: Text('    Friends\' Logs', style: TextStyle(fontSize: 20, fontFamily: 'Poppins'))
        ),
        Container(
          height:339,
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0,0,0,0),
              itemCount: goal.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Container(
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
                                Container( //CATEGORY TEXT
                                  height: 15,
                                  alignment: Alignment.centerLeft,
                                  child: Text(friendsList[index], style: TextStyle(fontSize: 12, fontFamily: 'Poppins'))
                                ),
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
          ),
        ),
        ]
    ),
    )
   
  );
}



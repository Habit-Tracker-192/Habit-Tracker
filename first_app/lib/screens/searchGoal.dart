// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/components/goal_card.dart';
import 'package:first_app/models/goalList.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';


class SearchGoal extends StatefulWidget {
  const SearchGoal ({Key? key}) : super(key: key);


  @override
  _SearchGoalState createState() => _SearchGoalState();
}

class _SearchGoalState extends State<SearchGoal> {
  List<Object> _goals = [];

  String text = "Search for a Goal";
  Map? map;
  bool isLoading = false;

  final TextEditingController? _search = TextEditingController();

  void onSearch() async {
    if(_search!.text.isNotEmpty){

      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      final uid = FireAuth().currentUser?.uid;
      await _firestore
          .collection('UserData')
          .doc(uid)
          .collection('goals')
          .where("goal", isEqualTo: _search?.text)
          .get()
          .then((value) {
            for (var i in value.docs){
              setState(() {
              map = i.data();
              //isLoading = false;
            });    
            print(map); 
            }
               
          });

      var data = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
        .collection('goals')
        .where("goal", isEqualTo: _search?.text)
        .get();
      setState(() {
        _goals = List.from(data.docs.map((doc)=> GoalEntity.fromSnapshot(doc)));
      });

    }
    
    if(map?['goal'] == _search?.text){
      
    }
     else{
      setState(() {
        text = "Goal not found: #${_search?.text}";
        map?[0] == _search?.text;
        //map == null;
        print(text);
      });
    }
  }

  @override
  Widget build(BuildContext context) => DefaultTabController (
      length: 1,
      child: Scaffold(
          appBar: (PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 154, 153, 238),
              //backgroundColor: Color.fromARGB(255, 231, 231, 241),

              title: Container(
                padding: EdgeInsets.fromLTRB(0,0,0,0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height:40,
                          width:250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: TextField(
                            controller: _search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(15,0,0,10),
                              hintText: 'Search Goal'
                          ))
                        ),

                        IconButton(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          icon: Icon(Icons.search_rounded, size: 30.0),
                          onPressed: onSearch,
                        ),   
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
          body:
          Column(
            children: [
              ListView.builder(
              padding: EdgeInsets.fromLTRB(0,20,0,0),
              itemCount: _goals.length,
              shrinkWrap: true,
               itemBuilder: (BuildContext context, int index) => GoalCard(_goals[index] as GoalEntity) 
              
              ),
              Expanded(child: map?['goal'] != _search?.text ?
                _search!.text.isNotEmpty ?
                ListTile(
                  onTap: (){},
          
                  title: Text("              Goal #${_search?.text} not found.",
                  style: TextStyle(                   
                    color: Color.fromARGB(255, 33, 33, 34),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  ),

                )
                :Container()
                : Container(),
                )
            ],
          )
      )
  );
 }

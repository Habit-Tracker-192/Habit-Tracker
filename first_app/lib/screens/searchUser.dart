
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


class SearchUser extends StatefulWidget {
  const SearchUser ({Key? key}) : super(key: key);


  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  String text = "Search for User Detail";
  Map? map;
  bool isLoading = false;

  final TextEditingController? _search = TextEditingController();

  void onSearch() async {
    if(_search!.text.isNotEmpty){

      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      // setState(() {
      //   isLoading = true;
      // });

      await _firestore
          .collection('UserData')
          .where("username", isEqualTo: _search?.text)
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
    }
    
    if(map?['username'] == _search?.text){
      
    } else{
      setState(() {
        text = "User is not found for that specific ID: #${_search?.text}";
        map == null;
        print(text);
      });
    }
  }
  

  @override
  Widget build(BuildContext context) => DefaultTabController (
      length: 2,
      child: Scaffold(
          appBar: (PreferredSize(
            preferredSize: Size.fromHeight(85.0),
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
                              hintText: 'Search User'
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
          SafeArea(
            child: Column(
              children: [
                map != null ?    
                Expanded(child: 
                map?['username'] == _search?.text ?
                ListTile(
                  onTap: (){},
                  leading: Icon(Icons.account_circle_rounded, color: Color.fromRGBO(100, 88, 204, .9), 
                  size: 45,),
                  title: Text(map?['username'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                  subtitle: Text(map?['email']),
                  //trailing: Icon(Icons.chat, color: Colors.black),

                )
                  :Container()
                )
                : Container(),

                map != null ?    
                Expanded(child: map?['username'] != _search?.text ?
                ListTile(
                  onTap: (){},
          
                  title: Text("              User #${_search?.text} not found.",
                  style: TextStyle(                   
                    color: Color.fromARGB(255, 33, 33, 34),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  ),

                )
                :Container())
                : Container(),
                  ],
            ),

            
            )
           
      )
  );

}









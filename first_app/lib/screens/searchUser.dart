
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
  Map<String, dynamic> ?userMap;
  bool isLoading = false;

  final TextEditingController? _search = TextEditingController();

  void onSearch() async {
    if(_search!.text.isNotEmpty){

      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      setState(() {
        isLoading = true;
      });

      await _firestore
          .collection('UserData')
          .where("username", isEqualTo: _search?.text)
          .get()
          .then((value) {
            setState(() {
              userMap = value.docs[0].data();
              isLoading = false;
            });    
            print(userMap);    
          });
    }
    
    if(userMap?['username'] == _search?.text){
      
    } else{
      setState(() {
        text = 'User not found';
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
            
            child: userMap != null ?    
            Expanded(child: ListTile(
              onTap: (){},
              leading: Icon(Icons.account_box, color: Colors.black),
              title: Text(userMap?['username'],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
              ),
              subtitle: Text(userMap?['email']),
              trailing: Icon(Icons.chat, color: Colors.black),

            )
            ): Container(),)
           
          // body: TabBarView(
          //   children: [
          //     Recent()
          //     //Completed(),
          //     //All(),
          //   ],)
      )
  );

}


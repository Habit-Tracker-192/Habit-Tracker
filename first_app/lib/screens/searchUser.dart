
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:first_app/components/alert_dialog.dart';
import '../services/authenticate.dart';
import 'package:intl/intl.dart';

class SearchUser extends StatefulWidget {
  const SearchUser ({Key? key}) : super(key: key);


  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  String text = "Search for User Detail";
  Map? map;
  bool isLoading = false;
  List<dynamic> friendsList = [];
  List<dynamic> friendRequestList = [];
  

  final uid = FireAuth().currentUser?.uid;
  final TextEditingController? _search = TextEditingController();
  String? uidFriend;

  Future<String?> searchUsername(String? uid) async {
    final docRef = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
    String username = docRef.get("username");
    return username;
  }
  
  Future<String?> searchUID(String? username) async {
    String? uidFriend;
    if(username!.isNotEmpty){
      await FirebaseFirestore.instance.collection('UserData')
            .where("username", isEqualTo: username)
            .get()
            .then((value) {
              uidFriend = value.docs.first.id;
              print('uidFriend is $uidFriend');
            });
    }
    return uidFriend;
  }

  Future<bool> requestAlreadySent(String uidUser) async{
    bool result = false;
    String? username = await searchUsername(uid);
    if(uidUser.isNotEmpty){
      await FirebaseFirestore.instance.collection('UserData').doc(uidUser).collection('notifications')
            .where("fromUser", isEqualTo: username)//from current user
            .where("typeNotif",isEqualTo: 0)//a friend request
            .get()
            .then((value) {
              if(value.size>=1){
                result = true;
              }
            });
    }
    print(result);
    return result;
  }

  void onSearch() async {
    if(_search!.text.isNotEmpty){
      String? user = _search?.text;
      uidFriend = await searchUID(user);
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore
          .collection('UserData')
          .where("username", isEqualTo: user)
          .get()
          .then((value) {
            for (var i in value.docs){
              setState(() {
              map = i.data();
              //isLoading = false;
            });    
            print("map: $map"); 
            }
               
          });

      //GET friends list
      await  _firestore.collection("UserData").doc(uid).collection('friends').get().then((event) {
        for (var doc in event.docs) {
          String friendUsername = doc.data().values.first;
          if (!friendsList.contains(friendUsername)) {
            friendsList.add(friendUsername);
          }
        }
      });
      print("friends list: $friendsList");

      //GET friend request list
      //if you already sent a request and user has not yet accepted
      if(await requestAlreadySent(uidFriend!) && !(friendsList.contains(user)) && !friendRequestList.contains(user)){
        friendRequestList.add(user);
      }
      print("friend request list: $friendRequestList");
    }
    
    if(map?['username'] == _search?.text){
    } else{
      setState(() {
        text = "User is not found for that specific ID: #${_search?.text}";
        map?[0] == _search?.text;
        //map == null;
        print(text);
      });
    }
  }
  

  @override
  Widget build(BuildContext context) => DefaultTabController (
      length: 2,
      child: Scaffold(
          appBar: (PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 154, 153, 238),
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
                Container(
                  child: ListTile(
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
                    // subtitle: Text(map?['email']),
                    trailing: (() {
                      String name = _search!.text;
                      //IF USER IS ALREADY YOUR FRIEND
                      if(friendsList.contains(name)){
                        return IconButton(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          icon: Icon(Icons.clear_rounded, size: 30.0),
                          onPressed: () async {
                            final action = await AlertDialogs.RemoveFriendDialog(context, name, 'Remove Friend');
                          },
                        );
                      }
                      //YOU ALREADY SENT A FRIEND REQUEST
                      else if(friendRequestList.contains(name)){ 
                        return Text(
                          'Friend Request sent', 
                          style: TextStyle(
                            color: Color.fromARGB(255, 121, 38, 216), 
                            fontWeight: FontWeight.bold
                          ),
                        );
                      }
                      //IF USER IS NOT YOUR FRIEND
                      else{
                        return RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          onPressed: () async {
                              final uidFriend = await searchUID(name);
                              print(uidFriend);
                              final action = await AlertDialogs.AddFriendDialog(context, name, uidFriend!,'Add User ');
                              if (!friendRequestList.contains(name)){
                                friendRequestList.add(name);
                              }
                            },
                          child: Text(
                            'Add', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      }()), 

                  ),
                )
                  :Container()
                )
                : Container(),
  
                Expanded(child: map?['username'] != _search?.text ?
                _search!.text.isNotEmpty ?
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
                :Container()
                : Container(),
                )
                
                  ],
            ),

            
            )
           
      )
  );

}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  String? name;
  String? email;
  late num age;
  String? gender;
  List<Object>? friends;
  String? bio;
  late Timestamp lastlogin;

  
  // late num percent;
  // late num progress;
  

  UserEntity();

  Map<String, dynamic> toJson() => {'name': name, 'email': email,'age': age, 'gender': gender, 'friends': friends, 'bio': bio, 'lastlogin': lastlogin};

  UserEntity.fromSnapshot(snapshot): 
      name = snapshot.data()['name'],
      email = snapshot.data()['email'],   
      age = snapshot.data()['age'], 
      gender = snapshot.data()['gender'],
      friends = snapshot.data()['friends'],
      bio = snapshot.data()['bio'],
      lastlogin = snapshot.data()['lastlogin'];
}

import 'dart:ffi';

class UserEntity {
  String? name;
  String? email;
  late num age;
  String? gender;
  List<Object>? friends;
  String? bio;

  
  // late num percent;
  // late num progress;
  

  UserEntity();

  Map<String, dynamic> toJson() => {'name': name, 'email': email,'age': age, 'gender': gender, 'friends': friends, 'bio': bio};

  UserEntity.fromSnapshot(snapshot): 
      name = snapshot.data()['name'],
      email = snapshot.data()['email'],   
      age = snapshot.data()['age'], 
      gender = snapshot.data()['gender'],
      friends = snapshot.data()['friends'],
      bio = snapshot.data()['bio'];
}

import 'dart:ffi';

class FriendEntity {
  String? username;
  

  
  // late num percent;
  // late num progress;
  

  FriendEntity();

  Map<String, dynamic> toJson() => {'username': username};

  FriendEntity.fromSnapshot(snapshot): 
      username = snapshot.data()['username'];
    
}

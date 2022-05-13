import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalEntity {
  String? goal;
  String? goalcategory; 
  String? frequency;
  late num total;//times
  late num duration;
  String? desc;
  late Timestamp lastlog;
  
  late num percent;
  late num progress;
  

  GoalEntity();

  Map<String, dynamic> toJson() => {'goal': goal, 'goalcategory': goalcategory,'percent': percent, 'progress': progress, 'total': total};

  GoalEntity.fromSnapshot(snapshot)
    : goal = snapshot.data()['goal'],
      goalcategory = snapshot.data()['goalcategory'],   
      percent = snapshot.data()['percent'], 
      progress = snapshot.data()['progress'],
      frequency = snapshot.data()['frequency'],
      total = snapshot.data()['total'],
      duration = snapshot.data()['duration'],
      desc = snapshot.data()['desc'],
      lastlog = snapshot.data()['lastlog']
      ;
}

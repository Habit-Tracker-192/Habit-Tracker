import 'dart:ffi';

class GoalEntity {
  String? goal;
  String? goalcategory; 
  late num percent;
  late num progress;
  late num total;
  

  GoalEntity();

  Map<String, dynamic> toJson() => {'goal': goal, 'goalcategory': goalcategory,'percent': percent, 'progress': progress, 'total': total};

  GoalEntity.fromSnapshot(snapshot)
    : goal = snapshot.data()['goal'],
      goalcategory = snapshot.data()['goalcategory'],   
      percent = snapshot.data()['percent'], 
      progress = snapshot.data()['progress'],
      total = snapshot.data()['total']
      ;
}

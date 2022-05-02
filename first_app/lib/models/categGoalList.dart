import 'dart:ffi';

class CategGoalEntity {
  String? goal;
  String? goalcategory; 
  late num percent;
  late num progress;
  late num total;
  

  CategGoalEntity();

  Map<String, dynamic> toJson() => {'goal': goal, 'goalcategory': goalcategory,'percent': percent, 'progress': progress, 'total': total};

  CategGoalEntity.fromSnapshot(snapshot)
    : goal = snapshot.data()['goal'],
      goalcategory = snapshot.data()['goalcategory'],   
      percent = snapshot.data()['percent'], 
      progress = snapshot.data()['progress'],
      total = snapshot.data()['total']
      ;
}

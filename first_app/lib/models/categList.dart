// import 'dart:ffi';

// class CategoryEntity {
//   String? category;
//   late num categProgress;
//   late num categTotal;
  

//   CategoryEntity();

//   Map<String, dynamic> toJson() => {'category': category, 'categProgress': categProgress,'categTotal': categTotal};

//   CategoryEntity.fromSnapshot(snapshot)
//     : category = snapshot.data()['category'],
//       categProgress = snapshot.data()['categProgress'],
//       categTotal = snapshot.data()['categTotal']
//       ;
// }

import 'dart:ffi';

class CategoryEntity {
  String? category;
  late num categProgress;
  late num categTotal;
  late num categTargetHours;
  String? categDesc;
  late bool hasGoal;
  //late num goalCount;
  

  CategoryEntity();

  Map<String, dynamic> toJson() => {
    'category': category,
    'categProgress': categProgress,
    'categTotal': categTotal,
    'categTargetHours': categTargetHours,
    'categDesc': categDesc,
    'hasGoal': hasGoal,
    //'goalCount': goalCount
    };

  CategoryEntity.fromSnapshot(snapshot)
    : category = snapshot.data()['category'],
      categProgress = snapshot.data()['categProgress'],
      categTotal = snapshot.data()['categTotal'],
      categTargetHours = snapshot.data()['categTargetHours'],
      categDesc = snapshot.data()['categDesc'],
      hasGoal = snapshot.data()['hasGoal']
      //goalCount = snapshot.data()['goalCount']
      ;
}

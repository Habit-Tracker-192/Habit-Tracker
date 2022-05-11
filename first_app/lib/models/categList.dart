import 'dart:ffi';

class CategoryEntity {
  String? category;
  late num categProgress;
  late num categTotal;
  late num categTargetHours;
  String? categDesc;
  

  CategoryEntity();

  Map<String, dynamic> toJson() => {
    'category': category,
    'categProgress': categProgress,
    'categTotal': categTotal,
    'categTargetHours': categTargetHours,
    'categDesc': categDesc
    };

  CategoryEntity.fromSnapshot(snapshot)
    : category = snapshot.data()['category'],
      categProgress = snapshot.data()['categProgress'],
      categTotal = snapshot.data()['categTotal'],
      categTargetHours = snapshot.data()['categTargetHours'],
      categDesc = snapshot.data()['categDesc']
      ;
}

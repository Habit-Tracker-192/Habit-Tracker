import 'dart:ffi';

class CategoryEntity {
  String? category;
  late num categProgress;
  late num categTotal;
  

  CategoryEntity();

  Map<String, dynamic> toJson() => {'category': category, 'categProgress': categProgress,'categTotal': categTotal};

  CategoryEntity.fromSnapshot(snapshot)
    : category = snapshot.data()['category'],
      categProgress = snapshot.data()['categProgress'],
      categTotal = snapshot.data()['categTotal']
      ;
}

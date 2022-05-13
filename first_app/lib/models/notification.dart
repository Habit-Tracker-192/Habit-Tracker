import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';


class NotificationEntity {
  String? notifMessage;
  String? fromUser;
  late Timestamp ago;
  String? uidSender;
  late num typeNotif;// 0 if request    1 if request result

  NotificationEntity();

  Map<String, dynamic> toJson() => {'notifMessage': notifMessage, 'fromUser': fromUser,'ago': ago, 'uidSender': uidSender, 'typeNotif': typeNotif};

  NotificationEntity.fromSnapshot(snapshot): 
      notifMessage = snapshot.data()['notifMessage'],
      fromUser = snapshot.data()['fromUser'],   
      ago = snapshot.data()['ago'],
      uidSender = snapshot.data()['uidSender'],
      typeNotif = snapshot.data()['typeNotif'];
}

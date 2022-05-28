// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/categList.dart';
import 'package:first_app/services/authenticate.dart';
import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel}

class EditCateg {

  
  //DocumentReference reference = FirebaseFirestore.instance.reference();
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    CategoryEntity category,
    String title,
    String body,
    
  ) async {
    final TextEditingController? _search = TextEditingController(); //text:1.toString()
    String? value;
    var _textformfield_search = GlobalKey<FormFieldState>();

    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          //contentPadding: EdgeInsets.fromLTRB(0,0,20,0),
          //title: Text("Category: " + category, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          //content: Text(body),
          actions: <Widget>[
            Container( //CATEGORY TEXT
            height: 50,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10,0,0,0),
            child: Text("Category: " + category.category.toString(), style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 72, 68, 80)))
          ),
          Center(child:
              SizedBox(height: 10)
            ),
          Container( //CATEGORY TEXT
            height: 30,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10,0,0,0),
            child: Text(body + ":", style: TextStyle(fontSize: 18, fontFamily: 'Poppins',
            color: Color.fromARGB(255, 72, 68, 80)))
          ),
          Center(child:
              SizedBox(height: 6)
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0,0,0,0),
              height:40,
              width:290,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextFormField(
                key: _textformfield_search,
                controller: _search,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(10,0,0,10),
                  hintText: 'Enter New Total Hours'
              ),
              validator: (value){
                if (value!.isEmpty){
                  return 'Please add total hours';
                }})
            ),
            Center(child:
              SizedBox(height: 20)
            ),
            Row(
              children: [
                Center(child:
                  SizedBox(width: 60)
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () async { 
                      final uid = FireAuth().currentUser?.uid;
                      if (int.parse(_search!.text) >= category.categProgress.toDouble()){
                                   
                      await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('categories').doc(category.category.toString()).update({'categTotal': (int.parse(_search.text))})
                            .whenComplete(() {
                             print("$category total updated"); }); 
                                                       
                      Navigator.of(context).pop(DialogsAction.yes);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialogTotalUpdated(context));}
                      else {
                      print("Invalid Hours!");
                      Navigator.of(context).pop(DialogsAction.yes);
                        showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialogInvalidHours(context));
                      }},
                  child: Text(
                    'Update', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
                  ),
                ),//Color.fromARGB(255, 57, 55, 58)
                Center(child:
                  SizedBox(width: 10)
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () => 
                      Navigator.of(context).pop(DialogsAction.cancel) ,
                  child: Text(
                    'Cancel', style: TextStyle(color: Color.fromARGB(255, 121, 38, 216), fontWeight: FontWeight.bold),
              ),
            )
              ],
            ),
            
          ],
        );
      }
    );
    return (action != null) ? action : DialogsAction.cancel;
    
  }
}

Widget _buildPopupDialogTotalUpdated(BuildContext context) {
    return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: const Text('Category \'Total Hours\' Updated!'),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    actions: <Widget>[
       FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
  
  }
  Widget _buildPopupDialogInvalidHours(BuildContext context) {
    return AlertDialog(
    title: const Text('Invalid Total Hours!'),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    actions: <Widget>[
       FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );}

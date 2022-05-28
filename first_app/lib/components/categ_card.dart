// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:first_app/components/alert_dialog_cat.dart';
import 'package:first_app/components/edit_categ.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/categList.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CategoryCard extends StatelessWidget {
  
  final CategoryEntity _category;

  CategoryCard(this._category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      height: 175,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/images/Education.png', 
              
                fit: BoxFit.cover
              )
            )
          ),
          Positioned(
            bottom: 6,
            left: 30,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Row(
                    children: [
                      
                      Text(_category.category.toString(), style: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                        fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                        letterSpacing: 1.3)),  
                      IconButton(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left:15),
                          icon: Icon(Icons.edit_rounded, size: 15.0),
                        
                          onPressed: () async{
                            final action = await EditCateg.yesCancelDialog(context, _category, 'Edit Category', 'Total Hours ');
                          },
                        ),  
                      IconButton(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left:0),
                          icon: Icon(Icons.clear_rounded, size: 15.0),
                        
                          onPressed: () async{
                            final action = await AlertDialogsCat.yesCancelDialog(context, _category.category.toString(), _category.hasGoal.toString(), 'Delete Category', 'Are you sure you want to delete ');
                          },
                        ),                         
                      Center(child:
                        SizedBox(width: 5)
                      ),//_category.categProgress/_category.categTotal)*100).toInt().toString() 
                          
                      Text(((_category.categProgress/_category.categTargetHours)*100).round().toString()+'% completed', style: TextStyle(color: Color.fromARGB(255, 72, 68, 80),
                          fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.bold,
                          letterSpacing: 1.3)),
                    ],
                  ),
                  
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,7,0,0),
                    child: LinearPercentIndicator(  //Category Linear Percent Indicator
                      width: 310,
                      animation: true,
                      lineHeight: 16,
                      center: Row(
                        children: [
                          Text(_category.categProgress.toString(), style: TextStyle(fontSize: 12, color:
                          Color.fromARGB(255, 228, 223, 238))),
                          Center(child:
                            SizedBox(width: 245)
                          ),
                          Text(_category.categTargetHours.toString(), style: TextStyle(fontSize: 12, color:
                          Color.fromARGB(255, 143, 141, 150))),
                        ],
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      percent: _category.categProgress/_category.categTargetHours,
                      progressColor: Color.fromARGB(255, 61, 68, 95),
                      backgroundColor: Color.fromARGB(255, 228, 223, 238),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}

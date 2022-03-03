import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 85, left: 25),
//               width: 360,
//               height: 500,
//               decoration: ShapeDecoration(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//                 color: Colors.white,
//                 shadows: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     offset: new Offset(10.0, 10.0),
//                     blurRadius: 10.0,
//                   ),
//                 ],
//               ),
//             )
//           ]
//         )      
//         );  
//   }
// }

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 85, left: 25),
              width: 360,
              height: 500,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: new Offset(10.0, 10.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.str,
                children: <Widget>[
                  TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.name,
                    validator: (value){
                      if (value!.isEmpty && value.length > 15) {
                        return 'too long';
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: 'Goal name',
                      fillColor: Color.fromARGB(255, 236, 224, 252),
                      labelText: 'Goal name',
                      labelStyle: const TextStyle(
                        fontSize: 18, color: Color.fromRGBO(100,88,204,1),
                      ),
                      
                      )
                      
                    ),
                    TextFormField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: 'How many hours would it take?',
                      fillColor: Color.fromARGB(255, 236, 224, 252),
                      labelText: 'Category',
                      labelStyle: const TextStyle(
                        fontSize: 18, color: Color.fromRGBO(100,88,204,1),
                      ),
                      
                      )
                      
                    ),
                    TextFormField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: 'How many hours would it take?',
                      fillColor: Color.fromARGB(255, 236, 224, 252),
                      labelText: 'Frequency',
                      labelStyle: const TextStyle(
                        fontSize: 18, color: Color.fromRGBO(100,88,204,1),
                      ),
                      
                      )
                      
                    ),
                    TextFormField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: 'Add a description',
                      fillColor: Color.fromARGB(255, 236, 224, 252),
                      labelText: 'Description',
                      labelStyle: const TextStyle(
                        fontSize: 18, color: Color.fromRGBO(100,88,204,1),
                      ),
                      
                      )
                      
                    ),

                ],
                  
                
              )
            )
           
          ]
        )      
        );  
  }
}
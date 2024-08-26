import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
       body:Padding(
         padding: const EdgeInsets.all(8.0),
         child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Table(
            border: TableBorder.all(color: Color.fromARGB(255, 20, 38, 48)),
            children: [
              TableRow(children: [
       ]),
              TableRow(children: [        
              ])
            ],
          ),
             ),
       )

    );
  }
}

import 'package:flutter/material.dart';
class Show_All_Visit_Hospilals extends StatelessWidget {
  const Show_All_Visit_Hospilals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column (children: [ 
   
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Card(
                       elevation: 50,
                       shadowColor: Color.fromARGB(255, 20, 38, 48),
                       color: Colors.white70,
                       child: Center(
                         child: SizedBox(
                width: 300,
                height: 220,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),    
                  child: Center(child: Text(' لم يتم زيارة أي مشفى بعد') ),
                 )),
                       )),
             ),]),

    );
  }
}
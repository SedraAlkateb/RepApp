import 'package:domina_app/Show_All_Visit_Hospitals.dart';
import 'package:domina_app/show%20hospital%20and%20doctor.dart';
import 'package:flutter/material.dart';

class ShowVisits extends StatelessWidget {
  const ShowVisits({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(bottom: TabBar(tabs: [

Tab(icon: Icon(Icons.groups),text: 'Doctors',),
Tab(icon: Icon(Icons.local_hospital),text: 'Hospitals',),


            ]),
              backgroundColor: Color.fromARGB(255, 20, 38, 48),
              title: Text(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DancingScript',
                    fontSize: 20,
                  ),
                  'My Visits'
                  ),
          
leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen.
            Navigator.pop(context);
          },
        ),
            ),

            body: TabBarView(children: [
              Show_All_Visit_Doctors(),
               Show_All_Visit_Hospilals()
            ]),
          )
          ),
    );
  }
}

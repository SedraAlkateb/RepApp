import 'package:flutter/material.dart';
 
class Places extends StatelessWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 38, 48),
        title: Text(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'DancingScript',
              fontSize: 20,
            ),
            'Representative Places'),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              subtitle: Column(
                children: <Widget>[
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(runSpacing: 8, spacing: 8, children: [
                        ActionChip(
                          label: Text("Damar"),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          backgroundColor: Color.fromARGB(255, 20, 38, 48),
                          onPressed: () => print("Perform some action here"),
                        )
                      ]),
                   
                      Wrap(runSpacing: 8, spacing: 8, children: [
                        ActionChip(
                          label: Text("Midan"),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          backgroundColor: Color.fromARGB(255, 20, 38, 48),
                          onPressed: () => print("Perform some action here"),
                        )
                      ]),
                      Wrap(runSpacing: 8, spacing: 8, children: [
                        ActionChip(
                          label: Text("Mazzah"),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          backgroundColor: Color.fromARGB(255, 20, 38, 48),
                          onPressed: () => print("Perform some action here"),
                        )
                      ]),
                    ],
                  ),
                  Text(
                    'First week',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  MaterialButton(
                      color: Color.fromARGB(255, 20, 38, 48),
                      child: Text(
                          style: TextStyle(color: Colors.white),
                          'Show the daily plan for this week'),
                      onPressed: () {})
                ],
              ),
            ),
            SizedBox(
              height: 0.02,
            ),
            ListTile(
              subtitle: Column(
                children: <Widget>[
                  Text(
                    'Second week',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  MaterialButton(
                      color: Color.fromARGB(255, 20, 38, 48),
                      child: Text(
                          style: TextStyle(color: Colors.white),
                          'Show the daily plan for this week'),
                      onPressed: () {})
                ],
              ),
            ),
            ListTile(
              subtitle: Column(
                children: <Widget>[
                  Text(
                    'Third week',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  MaterialButton(
                      color: Color.fromARGB(255, 20, 38, 48),
                      child: Text(
                          style: TextStyle(color: Colors.white),
                          'Show the daily plan for this week'),
                      onPressed: () {})
                ],
              ),
            ),
            ListTile(
              subtitle: Column(
                children: <Widget>[
                  Text(
                    'Fourth week',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  MaterialButton(
                      color: Color.fromARGB(255, 20, 38, 48),
                      child: Text(
                          style: TextStyle(color: Colors.white),
                          'Show the daily plan for this week'),
                      onPressed: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
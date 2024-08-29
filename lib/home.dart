import 'package:domina_app/Products.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
  "RED",
  "YELLOW",
  "CYAN",
  "BLUE",
  "GREY",
];
final List<Widget> images = [
  Container(
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  Container(
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  Container(
    decoration: BoxDecoration(
      color: Colors.cyan,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  Container(
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Plans',
            style: TextStyle(
                fontSize: 19,
                color: Color.fromARGB(208, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 20, 38, 48),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [  
                 MaterialButton(onPressed: () {  },
                 child: Text(' '), ),
                 MaterialButton( onPressed: () {  },
                 child: Text(''), ),
                    MaterialButton( onPressed: () {  },
                    child: Text(''), ),
              //  VerticalCardPager(align: ALIGN.CENTER, titles: [], images: [],)
              ],
            ),
          ),
        ),
        drawer: DrawerPage());
  }
}

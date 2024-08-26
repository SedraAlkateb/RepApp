import 'package:domina_app/Products.dart';
import 'package:domina_app/places.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

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
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 20, 38, 48),
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 20, 38, 48)),
                  accountName: Text(
                    "Lina Al-Mahayni",
                    style: TextStyle(fontSize: 18),
                  ),

                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 20, 38, 48),
                    child: Text(
                      "L",
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ),
                  accountEmail: null,
                  //circleAvatar
                ), //UserAccountDrawerHeader
              ),
              ListTile(
                leading: const Icon(Icons.ballot),
                title: const Text('All Plans'),
                onTap: () {
                  Navigator.pop(context);
                },
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text(' All Places'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Places()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.medication),
                title: const Text('All Products'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Products()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

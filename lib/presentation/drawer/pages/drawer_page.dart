import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.pushNamed(
                context, Routes.places);
            },
          ),
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text('All spec'),
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.spec
              );
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('All Doctors'),
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.doctors
              );
              
            },
          ),
            ListTile(
            leading: const Icon(Icons.group),
            title: const Text('All Hospital'),
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.hospital
              );
              
            },
          ),
        ],
      ),
    );
  }
}

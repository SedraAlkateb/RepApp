import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DrawerPage extends StatelessWidget {
   DrawerPage({super.key});
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
            leading: const Icon(Icons.location_city),
            title: const Text(' All Places'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.places,
                  (route) => false,
                );

              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text('All spec'),
            onTap: () {
             WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.spec,(route) => false,
                );

              });
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
          ListTile(
            leading: const Icon(Icons.branding_watermark_outlined),
            title: const Text('All brand'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.brand,(route) => true,
                );

              });


            },
          ),
          ListTile(
            leading: const Icon(Icons.local_pharmacy),
            title: const Text('All Pharmacy'),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.pharmacy,(route) => true,
                );

              });

            },
          ),
        ],
      ),
    );
  }
}
